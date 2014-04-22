
class Book
  attr_reader :author, :title
  attr_accessor :id, :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
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
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :title, :author, :books
  attr_accessor :borrower

  def initialize(name)
    @books = []
  end

  def add_book(book)
    @books << book
    book.id = Random.rand
  end

  def check_out_book(book_id, borrower)
    # @status = 'checked_out'
    @books.each do |book|
      if book.id == book_id
        if book.status == "available"
          book.status = "checked_out"
          return book
          #book.borrower = borrower
        else
          false
        end
      end
    end
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
