class Book:
    def __init__(self, title, author):
        self.title, self.author, self.available = title, author, True

class Library:
    def __init__(self):
        self.books = []

    def add(self, book):
        self.books.append(book)

    def issue(self, title):
        book = next((b for b in self.books if b.title == title), None)
        if book and book.available:
            book.available = False
            return True
        return False

    def return_book(self, title):
        book = next((b for b in self.books if b.title == title), None)
        if book and not book.available:
            book.available = True
            return True
        return False

library = Library()
library.add(Book("Python Basics", "A. Rao"))
print("Issue Python Basics:", library.issue("Python Basics"))
print("Issue again:", library.issue("Python Basics"))
print("Return Python Basics:", library.return_book("Python Basics"))
print("Available:", library.books[0].available)
