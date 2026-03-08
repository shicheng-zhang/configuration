#chr1_ll = 33
#chr1_hl = 47
#chr2_ll = 58
#chr2_hl = 64
#hc_ll = 65
#hc_hl = 90
#lc_ll = 97
#lc_hl = 122
import os
import random
import os
import random
def encrypt_decrypt ():
	while True:
		try:
			continuation = input ("Please confirm that you have entered the required transformation text to your source file (y/n):")
		except ValueError:
			print ("TYPR_INP_ERR.")
		if continuation == 'y' or continuation == 'Y':
			break
		elif continuation == 'n' or continuation == 'N':
			print ("Do that first please.")
			exit (1)
		else:
			print ("MODE_CHS_ERR.")
	# Ask for source file name and ensure it exists
	source_file = input ("Enter the source filename (include .txt): ")
	if not os.path.exists (source_file):
		print ("FILE_ERR: File does not exist.")
		exit (1)
	# Read the string
	file = open (source_file, "r")
	string = file.read ()
	file.close ()
	record = []
	temp_string = ""
	for x in range (1, 26):
		for character in string:
			n_val = ord (character)
			if n_val >= 33 and n_val <= 47:
				if n_val + x > 47:
					temp_string += chr (33 + ((n_val + x) - 48))
				else:
					temp_string += chr (n_val + x)
			elif n_val >= 58 and n_val <= 64:
				if n_val + x > 64:
					temp_string += chr (58 + ((n_val + x) - 65))
				else:
					temp_string += chr (n_val + x)
			elif n_val >= 65 and n_val <= 90:
				if n_val + x > 90:
					temp_string += chr (65 + ((n_val + x) - 91))
				else:
					temp_string += chr (n_val + x)
			elif n_val >= 97 and n_val <= 122:
				if n_val + x > 122:
					temp_string += chr (97 + ((n_val + x) - 123))
				else:
					temp_string += chr (n_val + x)
			elif n_val == 32:
				temp_string += chr (32)
		record += [temp_string]
		temp_string = ""
	# Compare permutations to dictionary
	dicfile = open ("en.dic", "r")
	dicwords = dicfile.readlines ()
	dicfile.close ()
	dicwords = [word.strip ().lower() for word in dicwords]
	cnt = 1
	match_found = False
	for string_out in record:
		split_words = string_out.lower ().split ()
		match_count = 0
		for word in split_words:
			if word in dicwords:
				match_count += 1
		if match_count >= len (split_words) // 2 and len (split_words) > 0:
			print ("Most likely decryption from Permutation +" + str (cnt) + ": " + string_out, end = "\n\n")
			match_found = True
		cnt += 1
	if match_found == False:
		random_index = random.randint (0, 24)
		print ("Encryption Permutation (+" + str (random_index + 1) + ") of string: " + record [random_index], end = "\n\n")
def plant_message ():
	plant = 0
	plant_err = 0
	encrypted_string = ""
	while True:
		plant_err = 0
		try:	
			plant = int (input ("Do you want to plant the message into a printout file? (0/1 for No/Yes):"))
		except ValueError:
			print ("STR_INT_FLT ERR.")
			plant_err = 1
		if plant not in range (0, 2):
			print ("MODE_CHS ERR.")
			plant_err = 1
		if plant_err == 0:
			break
	if plant == 1:
		# Ask for printout file name and make sure it exists
		print_file = input ("Enter the printout filename (include .txt): ")
		if not os.path.exists (print_file):
			print ("FILE_NOT_FOUND_ERR.")
			exit (1)
		encrypted_string = input ("Enter the message you want to plant and mix:")
		barr = []
		barr += [0]
		it_c = 0
		while True:
			barr_temp = random.randint (0, len (encrypted_string) - 1)
			if barr_temp not in barr:
				barr += [barr_temp]
				it_c += 1
			if it_c == 5:
				break
		barr.sort ()
		print (barr)
		segments = []
		for seg_plant in range (5):
			temp_string = ""
			if seg_plant == 4:
				for index in range (barr [4], len (encrypted_string)):
					temp_string += encrypted_string [index]
			else:
				for index in range (barr [seg_plant], barr [seg_plant + 1]):
					temp_string += encrypted_string [index]
			segments += [temp_string]
			temp_string = ""
		segments_arr = []
		size_sa = 0
		while True:
			rand_spot = random.randint (0, 4)
			if rand_spot not in segments_arr:
				segments_arr += [rand_spot]
				size_sa += 1
			if size_sa == 5:
				break
		final_string = ""
		for index2 in range (5):
			final_string += segments [segments_arr [index2]]
		# Append the scrambled string
		outfile = open (print_file, "a+")
		outfile.write (final_string + "\n")
		outfile.close ()
	else:
		print ("Message Not Planted. Exiting.")
def main ():
	while True:
		entry = -1
		while True:
			try:
				entry = int (input ("What mode would you like: (0 for encrypt and decrypt, 1 for planting a message, 2 for exit):"))
			except ValueError:
				print ("STR_INT_FLT ERR.")
				continue
			if entry != 0 and entry != 1 and entry != 2:
				print ("MODE_CHS_ERR.")
			else:
				break
		if entry == 0:
			encrypt_decrypt ()
		elif entry == 1:
			plant_message ()
		else:
			print ("Exiting.")
			exit (1)
main ()
