extends Node

const SAVES_DIR = "user://saves/"
const SAVE_EXT = ".emsave"

var _save_files: Array
# Example save file info:
# {
#   "fname": save1.emsave
#   "name": @PlayerData.save_name,
#   "mtime": modified_time,
#   "rev": "@Global.SaveRev
#   Possibly # gems, money, health
# }

func _ready():
    # Sanity check, creates saves dir if it doesn't exist
    var dir = Directory.new()
    if !dir.dir_exists(SAVES_DIR):
        dir.make_dir_recursive(SAVES_DIR);
    
    # Populate what saves are available
    get_avail_saves();


# Stores the list of files matching our save extension SAVE_EXT into the array
# _save_files. Use that array later on to list what saves have content in them
# or whatever.
func get_avail_saves():
    _save_files = Array();
    var dir = Directory.new()
    if dir.open(SAVES_DIR) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if !dir.current_is_dir():
                print("Found file: " + file_name)
                if file_name.ends_with(SAVE_EXT):
                    _save_file_record(file_name)
                    print("File should be a save file!")
                    
            file_name = dir.get_next()
    else:
        print("An error occurred when trying to access %s." % SAVES_DIR)	

# Saves the game to a file. See reference doc for more details.
func save_game(file_name):
    print("Saving game to file %s" % (SAVES_DIR + file_name))
    var file = File.new()
    if file.open(SAVES_DIR + file_name, File.WRITE) == OK:
        # Reference doc lists out what is saved in what order.
        file.store_16(Global.SaveRev)
        file.store_pascal_string (PlayerStore.save_name)
        file.store_16(PlayerStore.max_health)
        file.store_8(PlayerStore.starting_gem)
        file.store_8(PlayerStore.pack_unlocked_gems())
        file.store_32(PlayerStore.money)
        file.close()
    else:
        print("An error occurred when trying to create save file.")

func load_game(file_record):
    var file_name = file_record.fname;
    print("Load game from file %s" % (SAVES_DIR + file_name))
    var file = File.new()
    if file.file_exists(SAVES_DIR + file_name):
        if file.open(SAVES_DIR + file_name, File.READ) == OK:
            var savefile_rev = file.get_16()
            assert(savefile_rev == Global.SaveRev, "Save file is not compatible.")
            # Continue on because saves are compatible
            PlayerStore.save_name = file.get_pascal_string()
            PlayerStore.max_health = file.get_16()
            PlayerStore.starting_gem = file.get_8()
            PlayerStore.unpack_unlocked_gems(file.get_8())
            PlayerStore.money = file.get_32()
            file.close()
    else:
        print("An error occurred when tyring to load save file.")

# Call to append details about a save file to the _save_files array
func _save_file_record(file_name):
    var file = File.new()
    var frecord = {
        "fname": file_name
       }
    # Given the filename, we also assume it's in the save directory
    var full_filename = SAVES_DIR + file_name;
    
    frecord.mtime = file.get_modified_time(full_filename)
    if file.open(full_filename, File.READ) == OK:
        frecord.version = file.get_16()
        frecord.name = file.get_pascal_string()
        file.close()
    
    _save_files.push_back(frecord)
