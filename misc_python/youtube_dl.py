from pytube import YouTube
import sqlite3

db = sqlite3.connect('/Users/odinndagur/.odb/signtest.sqlite3')
signs = db.execute('select * from sign limit 5').fetchall()
print(signs)
db.close()

vid = YouTube('https://www.youtube.com/watch?v=L5z2VHQEEVw')