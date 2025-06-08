extends Node
class_name CSVReader

static func load_resources_csv_to_dict(path: String) -> Dictionary:
    var parsed_dict: Dictionary = {}
    var file: FileAccess        = FileAccess.open(path, FileAccess.READ)

    assert(file != null, "ERROR: failed to find file at path: %s" % path)

    if file != null:
        file.get_csv_line() # Skip headers
        while !file.eof_reached():
            var line: PackedStringArray = file.get_csv_line()
            if line.size() > 1 and !line.is_empty():
                parsed_dict[line[0]] = load(line[1]) # Add line to dictionary
    file.close()

    return parsed_dict
