import mysql.connector
import os_environt_variables 
import os

HOST = os.environ.get('HOST_BD')
USER = os.environ.get('USER_BD')
PASSWORD = os.environ.get('PASSWORD_BD')
DATABASE = os.environ.get('DATABASE_BD')

conn = mysql.connector.connect(host=HOST,user=USER,password=PASSWORD,database=DATABASE )

if conn.is_connected():
    print("Conexión exitosa a la base de datos.")
else:
    print("No se pudo establecer la conexión a la base de datos.") 

conn.close()