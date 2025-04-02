import requests
import os
from zipfile import ZipFile

def download_pdf_files():
    pdf_urls = {
        "Attachment_I": "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN473_RN478_RN480_RN513_RN536.pdf",
        "Attachment_II": "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_II_DUT_2021_RN_465.2021_tea.br_RN473_RN478_RN480_RN513_RN536.pdf"
    }
    
    for name, url in pdf_urls.items():
        response = requests.get(url)
        with open(f"{name}.pdf", "wb") as file:
            file.write(response.content)
    
    with ZipFile("ANS_Attachments.zip", "w") as zip_file:
        for name in pdf_urls.keys():
            zip_file.write(f"{name}.pdf")
    
    print("Download and compression completed!")

download_pdf_files()