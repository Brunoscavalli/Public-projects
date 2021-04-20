import pandas as pd

def create_query(excel_path, out_path):
    excel = pd.read_excel(excel_path)
    query = ""
    for i in range(0, len(excel)):
        query += "INSERT INTO " + excel.iloc[0][0] + " -- ▬▬▬▬▬▬▬ " +\
                    excel.iloc[i][2] + " - " + excel.iloc[i][3] + " "\
                    + excel.iloc[i][5] + " ▬▬▬▬▬▬▬\n"\
                 "SEL\n" \
                 "t1.*\n" \
                 ", col1 || \'_\' || col2 || \'_\' || c || \'_"\
                    + excel.iloc[i][3] + "_\' || \'" + excel.iloc[i][4] \
                    + "\'\n" \
                 "FROM " + excel.iloc[0][1] + " t1\n" \
                 "WHERE col3 = \'" + excel.iloc[i][2] +"\'\n" \
                 "AND col6 = \'" + excel.iloc[i][4] + "\'\n" \
                 "AND col7 = \'" + excel.iloc[i][5] + "\'\n"
        if excel.iloc[i][7] == "N":
            query += "AND col4 <> 1\n" \
                     "SAMPLE " + str(excel.iloc[i][6]) +"\n" \
                     ";\n" \
                     "DEL \n" \
                     "FROM " + excel.iloc[0][1] + "\n" \
                     "WHERE col3 = \'" + excel.iloc[i][2] +"\'\n" \
                     "AND col4 <> 1\n" \
                     "AND col5 IN ( SEL col5 FROM " + \
                        excel.iloc[0][0] + " )\n" \
                     ";\n\n\n"
        elif excel.iloc[i][7] == "S":
            query += "AND col4 <> 1\n" \
                     "SAMPLE " + str(excel.iloc[i][6]) +"\n" \
                     ";\n" \
                     "INSERT INTO " + excel.iloc[0][0] + " -- ▬▬▬▬▬▬▬ semente"\
                        " " + excel.iloc[i][2] + " - " + excel.iloc[i][3] + \
                        " " + excel.iloc[i][5] + " ▬▬▬▬▬▬▬\n" \
                     "SEL\n" \
                     "t1.*\n" \
                     ", col1 || \'_\' || col2 || \'_\' || col3 " +\
                        "|| \'_" + excel.iloc[i][3] + "_\' || \'" + \
                        excel.iloc[i][4] + "\'\n" \
                     "FROM " + excel.iloc[0][1] + " t1\n" \
                     "WHERE col3 = \'" + excel.iloc[i][2] +"\n" \
                     "AND col6 = \'" + excel.iloc[i][4] + "\n" \
                     "AND col7 = \'" + excel.iloc[i][5] + "\'\n" \
                     "AND col4 = 1\n" \
                     ";\n" \
                     "DEL \n" \
                     "FROM " + excel.iloc[0][1] + "\n" \
                     "WHERE col3 = \'" + excel.iloc[i][2] +"\'\n" \
                     "AND col4 <> 1\n" \
                     "AND col5 IN ( SEL col5 FROM " + \
                        excel.iloc[0][0] + " )\n" \
                     ";\n\n\n"
        else:
            query ="Corrija a coluna F, ela deve ser composta " \
                "apenas dos valores \"S\" ou \"N\""
            break
    print(query)
    if out_path == "":
        spt = excel_path.split("/")
        for i in range(0,len(spt)-1):
            out_path += spt[i] + "/"
        out_path += "query.txt"
        with open(out_path,mode="w", encoding="utf-8") as txt:
            txt.write(query)
    else:    
        out_path = out_path +"query.txt"
        with open(out_path,mode="w", encoding="utf-8") as txt:
            txt.write(query)
    

print("Insira o caminho ao arquivo de excel:")
excel_path = input()

print("\nInsira o local onde você quer que o arquivo com a query seja " \
     "depositado, deixe vazio caso deseje que ele seja colocado na mesma " \
     "pasta do excel:")
out_path = input()
"\n"
create_query(excel_path, out_path)