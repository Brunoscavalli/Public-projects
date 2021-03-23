'''
     Main part of the program
'''

# importing the required libraries
import pandas as pd # Creating and manipulating data structures and xmls files
import fitz  # Pdf manipulation *fitz is the "import" name for the PyPDFMu lib
import get_data

# Opening the pdf file and selecting the desired page
report = fitz.open('/home/bruno/Documentos/prog/Github/Report Reader/ExampleReport.pdf')
page = report[0]
# storing the location where the data in the pdf is from a file
locations = pd.read_excel('/home/bruno/Documentos/prog/Github/Report Reader/location1e.xlsx')
# geting the data
data_append = []
for j in range(6):
    data_append.append([])
    for i in range(16):
        data_append[j].append(get_data.sline_to_str(locations.loc[j][i],page))
#print(data_append)
df = pd.DataFrame(data_append, columns=['Report #', 'Date', 'Lab Technician',
                                'Department', 'Location', 'Requester',
                                'Req. Dep.', 'Req. Location', 'Sample',
                                'Measuring Tool', 'Batch', 'Material',
                                'A', 'B', 'C', 'Result'])
print(df.head(6))