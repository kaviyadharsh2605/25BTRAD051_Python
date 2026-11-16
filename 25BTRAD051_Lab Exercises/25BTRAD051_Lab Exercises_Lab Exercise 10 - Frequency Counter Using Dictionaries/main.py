sentence = "python makes data tasks simple and python makes learning fun"
counts = {}
for word in sentence.lower().split():
    counts[word] = counts.get(word, 0) + 1
print("Sentence:", sentence)
print("Word frequencies:")
for word, count in sorted(counts.items()):
    print(f"{word}: {count}")
