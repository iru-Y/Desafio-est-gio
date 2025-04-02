import tabula
import pandas as pd
from zipfile import ZipFile

def convert_pdf_to_csv():
    pdf_tables = tabula.read_pdf("Attachment_I.pdf", pages="all")
    
    procedures_df = pd.concat(pdf_tables)
    
    procedures_df.columns = [col.replace("OD", "Dental").replace("AMB", "Outpatient") for col in procedures_df.columns]
    
    procedures_df.to_csv("Health_Procedures.csv", index=False)
    
    with ZipFile("Test_Your_Name.zip", "w") as zip_file:
        zip_file.write("Health_Procedures.csv")
    
    print("Data transformation completed!")

convert_pdf_to_csv()