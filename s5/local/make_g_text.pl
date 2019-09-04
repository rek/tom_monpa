import os

from nltk import word_tokenize
from nltk.util import ngrams
from collections import Counter

corpus = []
# put corpus.txt into data/ folder
path = '../data'

# print(os.walk(path))
for i in next(os.walk(path))[2]:
    # print(i)
    if i.endswith('.txt'):
        f = open(os.path.join(path,i))
        corpus.append(f.read())

final = {}
count = 0 # fake to be cool with the if
for text in corpus:
    # print(text)
    token = word_tokenize(text)
    bigrams = ngrams(token,2)
    # print (Counter(bigrams))
    for line in Counter(bigrams):
        # print(line[1])
        # print('exists:')
        # print(line[0] in final)

        if line[0] in final:
            # print ('exists!')
            if line[1] in final[line[0]]:
                # print ('in array')
                count += 1
            else:
                # print ('not in array!')
                final[line[0]].append(line[1])
        else:
            # print ('new!')
            final[line[0]] = [line[1]]

        if line[1] in final:
            count += 1
        else:
            final[line[1]] = []

for key, value in final.items():
    # print(key, value)
    print(f">{key}")
    for item in value:
        print(f"{item.strip()}")
