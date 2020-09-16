'''
    This file is intended to provide functions for reading data
'''

import fitz  # Deals with pdf manipulation, install PyMuPDF
from PIL import Image, ImageEnhance # Opening, storing and enhancing an image
import pytesseract # Optical recognition library that reads a stored image
import os # Delete the temp image after it is used
from itertools import groupby

# Data from an img
def img_to_str(data_location, page):
    # Transform str to tuple -> clip the desired region -> create png image ->
    # enhance png -> transform to str -> return str
    data_location = tuple(map(float,data_location.split(', ')))
    pix = page.getPixmap(matrix=fitz.Matrix(3,3), clip=data_location)
    pix.writePNG('temp.png')
    im = Image.open("temp.png")
    enhancer = ImageEnhance.Contrast(im)
    im = enhancer.enhance(4)
    im.save('temp.png')
    text = pytesseract.image_to_string(Image.open('temp.png'))
    os.remove('temp.png')
    return text

# Data from a single line:
def sline_to_str(data_location, page):
    data_location = list(map(float,data_location.split(', ')))
    avg_y = (data_location[1]+data_location[3])/2
    data_location[1] = avg_y-1
    data_location[3] = avg_y+1
    words = page.getText('words')
    words.sort(key=lambda w: (w[3], w[0]))
    mywords = [w for w in words if fitz.Rect(w[:4]).intersects(data_location)]
    group = groupby(mywords, key=lambda w: w[3])
    for y1, gwords in group:
        mywords = " ".join(w[4] for w in gwords)
    return mywords