import sys
import json

warning_message = u'::warning file={},line={},col={}::{}'
suggestion_message = u'{} Suggestions: `{}`'

parsed_filename = sys.argv[1]
logfile = sys.argv[2]
with open(logfile, 'r', encoding='UTF-8') as f:
	lines = f.readlines()
	# The front matter might contain error messages, etc. Printing out
	# so you can debug in the actions log
	front_matter = ''.join(lines[0:-2])
	print(front_matter)

	# The JSON outputted will be the last line
	print("Here's the JSON")
	a = json.loads(lines[-1])
	for match in a["matches"]:
		replacement_suggestions = list(map(lambda replacement: replacement["value"], match["replacements"]))
		replacement_string = "; ".join(replacement_suggestions)
		msg = suggestion_message.format(match["message"], replacement_string)
		warning = warning_message.format(parsed_filename, 1, match["offset"], msg)
		print(warning)
