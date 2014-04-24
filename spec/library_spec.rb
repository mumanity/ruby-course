require "./library.rb"
# require 'pry-debugger'

describe Book do
  it "has a title and author, and nil id" do
    book = Book.new("The Stranger", "Albert Camus")

    # binding.pry

    expect(book.title).to eq "The Stranger"
    expect(book.author).to eq "Albert Camus"
    expect(book.id).to be_nil
  end

  it "has a default status of available" do
    book = Book.new("testing", "dude guy")
    expect(book.status).to eq 'available'
  end

  it "can be checked out" do
    book = Book.new("oar testing", "the dude")
    did_it_work = book.check_out
    expect(did_it_work).to be_true
    expect(book.status).to eq 'checked_out'
  end

  it "can't be checked out twice in a row" do
    book = Book.new("bowling", "the dude")
    did_it_work = book.check_out
    expect(did_it_work).to eq(true)

    did_it_work_again = book.check_out
    expect(did_it_work_again).to eq(false)

    expect(book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    book = Book.new("guns", "the dude")
    book.check_out
    book.check_in
    expect(book.status).to eq 'available'
  end
end

describe Borrower do
  it "has a name" do
    borrower = Borrower.new("Mike")
    expect(borrower.name).to eq "Mike"
  end
end

describe Library do

  it "starts with an empty array of books" do
    lib = Library.new("blue")
    pink = Book.new('pink', 'you')
    lib.add_book(pink)
    expect(lib.books.count).to eq(1)
  end

  it "add new books and assigns it an id" do
    lib = Library.new("austin")
    nausea = Book.new("Nausea", "author")
    lib.add_book(nausea)
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    lib = Library.new("green")
    one = Book.new("One", "author")
    lib.add_book(one)
    two = Book.new("two", "author")
    lib.add_book(two)
    three = Book.new("three", "author")
    lib.add_book(three)

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book by its id" do
    lib = Library.new('yellow')
    seuss = Book.new("Green Eggs and Ham", "Dr. Seuss")
    lib.add_book(seuss)
    book_id = lib.books.first.id

    # Sam wants to check out Green Eggs and Ham
    sam = Borrower.new('Sam-I-am')
    book = lib.check_out_book(book_id, sam)

    # The checkout should return the book
    expect(book).to be_a(Book)
    expect(book.title).to eq "Green Eggs and Ham"

    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    lib = Library.new('aqua')
    lib.add_book(pizza = Book.new("The Brothers Karamazov", "Fyodor Dostoesvky"))
    book_id = lib.books.first.id

    # Big Brother wants to check out The Brothers Karamazov
    bro = Borrower.new('Big Brother')
    book = lib.check_out_book(book_id, bro)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book_id) ).to eq 'Big Brother'
  end

  it "does not allow a book to be checked out twice in a row" do
    lib = Library.new('fun')
    howdy = Book.new("Surely You're Joking Mr. Feynman", "Richard Feynman")
    lib.add_book(howdy)
    book_id = lib.books.first.id

    # Leslie Nielsen wants to double check on that
    nielsen = Borrower.new('Leslie Nielsen')
    book = lib.check_out_book(book_id, nielsen)

    # The first time should be successful
    expect(book).to be_a(Book)

    # However, you can't check out the same book twice!
    book_again = lib.check_out_book(book_id, nielsen)
    expect(book_again).to be_nil

    son = Borrower.new('Leslie Nielsen the 2nd')
    book_again = lib.check_out_book(book_id, son)
    expect(book_again).to be_nil
  end

  it "allows a Borrower to check a book back in" do
    lib = Library.new('thing')
    bob = Book.new("Finnegans Wake", "James Joyce")
    lib.add_book(bob)
    book_id = lib.books.first.id

    # Bob wants to check out Finnegans Wake
    bob = Borrower.new('Bob Bobber')
    book = lib.check_out_book(book_id, bob)

    # o wait he changed his mind
    lib.check_in_book(book)

    # The book should now be marked as available!
    expect(book.status).to eq 'available'
  end

  it "does not allow a Borrower to check out more than two Books at any given time" do
    # yeah it's a stingy library
    lib = Library.new('another')
    hey = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    lib.add_book(hey)
    hi = Book.new("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.add_book(hi)
    holla = Book.new("JavaScript: The Good Parts", "Douglas Crockford")
    lib.add_book(holla)

    jackson = Borrower.new("Michael Jackson")
    book_1 = lib.books[0]
    book_2 = lib.books[1]
    book_3 = lib.books[2]

    # The first two books should check out fine
    book = lib.check_out_book(book_1.id, jackson)
    expect(book.title).to eq "Eloquent JavaScript"

    book = lib.check_out_book(book_2.id, jackson)
    expect(book.title).to eq "Essential JavaScript Design Patterns"

    # However, the third should return nil
    book = lib.check_out_book(book_3.id, jackson)
    expect(book).to be_nil
  end

  it "returns available books" do
    lib = Library.new('moar lib')
    a = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    lib.add_book(a)
    b = Book.new("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.add_book(b)
    c = Book.new("JavaScript: The Good Parts", "Douglas Crockford")
    lib.add_book(c)

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    jordan = Borrower.new("Michael Jordan")
    book = lib.check_out_book(lib.available_books.first.id, jordan)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    lib = Library.new('hill')
    g = Book.new("Harry Potter", "J. K. Rowling")
    lib.add_book(g)
    book_id = lib.books.first.id

    # First, we check out the book
    vick = Borrower.new("Michael Vick")
    book = lib.check_out_book(book_id, vick)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Vick'

    # When we check in a book, the Library does not care who checks it in
    lib.check_in_book(book)

    # Another person should be able to check the book out
    schumacher = Borrower.new("Michael Schumacher")
    book = lib.check_out_book(book_id, schumacher)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Schumacher'
  end

  it "returns borrowed books" do
    lib = Library.new('donsies')
    h = Book.new("Eloquent JavaScript", "Marijn Haverbeke")
    lib.check_in_book(h)
    i = Book.new("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.check_in_book(i)
    j = Book.new("JavaScript: The Good Parts", "Douglas Crockford")
    lib.check_in_book(j)

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    kors = Borrower.new("Michael Kors")
    book = lib.check_out_book(lib.borrowed_books.first.id, kors)

    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.first).to be_a?(Book)
  end
end
