count = 0
replaced_content = ""
with open("wav_file_list.txt") as file_list:
    wav_file_list = [line.rstrip() for line in file_list]

with open("input_file.txt") as file1:
    lines = file1.readlines()
    #print(lines)
    for line in lines:
        if line == "          C1: configs/resources/audio/WS21_MZ-AW-VE_0.25_0.25_0.5.wav\n":
            new_line = line.replace("          C1: configs/resources/audio/WS21_MZ-AW-VE_0.25_0.25_0.5.wav\n", "          C1: configs/resources/audio/" + wav_file_list[count] + '\n')
            count += 1
        else:
            new_line = line
        replaced_content = replaced_content + new_line
        print(count)

#Open file in write mode
write_file = open("demo.txt", "w")
write_file.write(replaced_content)
write_file.close()