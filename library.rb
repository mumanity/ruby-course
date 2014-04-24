require 'pry-debugger'

class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower

  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
    @borrower = nil
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      true
    else
      false
    end
  end

  def check_in
    @status = 'available'
  end

end

class Borrower
  attr_reader :name
  attr_accessor :count
  def initialize(name)
    @name = name
    @count = 0
  end
end

class Library
  attr_reader :title, :author, :books
  attr_accessor :borrower, :available

  def initialize(name)
    @books = []
  end

  def add_book(book)
    @books << book
    book.id = Random.rand
  end

  def check_out_book(book_id, borrower)
    # find a book with matching id
    # if no book found, will be an empty array
    # book = @books.select do |book|
    #   book.id == book_id
    # end

    # rest book to the first value in the book array, in this case, a book. If array is empty, will be nil
    # book = book[0]

    # this is the same as above
    book = nil
    @books.each do |b|
      if b.id == book_id
        book = b
      end
    end

    if book && borrower.count < 2 && book.status == "available"
      book.status = "checked_out"
      book.borrower = borrower
      borrower.count += 1
      return book
    else
      nil
    end
  end


  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        if book.status == 'checked_out'
          return book.borrower.name
        end
      end
    end
  end


  def check_in_book(book)
      book.check_in
  end


  def available_books
    available = []
    @books.each do |x|
    if x.status == 'available'
      available << x
      end
    end
    available
  end

  def borrowed_books
    @borrowed = []
    @books.each do |x|
    if x.status == 'checked_out'
      @borrowed << x
      @borrowed
      end
    end
  end
end
