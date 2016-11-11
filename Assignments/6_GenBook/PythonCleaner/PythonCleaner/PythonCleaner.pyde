import random
from random import randrange
import re
import csv
import sys

textName = 'loveCallsUs'

source = open('texts/'+textName+'.txt', 'r')
ts = open('texts/synAntNoHyph.txt', 'r')
ts2 = open('texts/MobyTs.txt', 'r')

export = open('export.txt', 'w')
csvExport = open('exports/'+textName+'.csv', 'wb')

def setup():
    size(100, 100)

    rawTs = ts.readlines()
    rawTs2 = ts2.readlines()
    
    rawlines = source.readlines()
    lines = []
    iterations = []
    numIterations = 5 

    for raw in range(len(rawlines)):
        aLine = rawlines[raw].split()
        lines.append(aLine)
        
    #initialize csv with source
    writer = csv.writer(csvExport)
    writer.writerow( ('word', 'isNew', 'iteration', 'endLine') )
    print lines
    for x in range(len(lines)):
        isEnd = 0 #is it the end of a line?
        for y in range(len(lines[x])):
            word = lines[x][y]
            if y == len(lines[x])-1: #adjusted for index
                isEnd = 1
            writer.writerow( (word, '0' , '0' , isEnd ) )
        
    #first, print original text
    for line in lines:
        joined = ' '.join(line)
        print>>export, joined
    print>>export, '\n'

    for z in range(numIterations):
        # Find Synonyms
        for i in range(len(lines)):  # loop over lines
            for j in range(len(lines[i])):  # loop through words
                
                currentWord = re.sub(r'[^\w\s]','',lines[i][j]).title() #remove punctuation
                # print currentWord
                
                found = False #reset found (in first thesaurus)
                
                for k in range(len(rawTs)):  # loop through ts (first thesaurus)
                    if random.random() > 0.0:
                        if rawTs[k].startswith(currentWord+'.'): #if it's a period, grab the word right after
                                # print rawTs[k]
                                index = random.randint(1,len(rawTs[k].split())-1)
                                synonym = rawTs[k].split()[index]
                                synonym = str('_'+synonym)
                                found = True
                        if rawTs[k].startswith(currentWord+','): #if it's a comma, grab the second word
                                # print rawTs[k]
                                if len(rawTs[k].split())-1 >= 2:
                                    index = random.randint(2,len(rawTs[k].split())-1)
                                else:
                                    index = 1
                                synonym = rawTs[k].split()[index] 
                                synonym = str('_'+synonym)
                                found = True
    
                if found == True:
                    if j > 0:
                        synonym = synonym.lower()
                        synonym = re.sub(r'[^\w\s]','',synonym)
                        synonym = synonym.strip(';')
                    lines[i][j] = synonym
         
        #write to CSV 
        print lines                                     
        for x in range(len(lines)):
            for y in range(len(lines[x])):
                isSyn = 0 #is it a synonym?
                isEnd = 0 #is it the end of a line?
                if lines[x][y].startswith('_'): #detect if its a synonym
                    lines[x][y] = lines[x][y][1:] #strip synonym identifier
                    isSyn = 1
                if y == len(lines[x])-1: #adjusted for index
                    isEnd = 1
                word = lines[x][y]
                writer.writerow( (word, isSyn , (z+1) , isEnd) )
                # print word
                    
            # print str(lines[x])
            joined = ' '.join(lines[x])  
            print>>export, joined
        print>>export, '\n'
            
        iterations.append(lines)
    noStroke()
    fill(0,255,0)
    ellipse(width/2,height/2,80,80)
    
    csvExport.close()