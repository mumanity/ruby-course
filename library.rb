
class Book
  attr_reader :author, :title, :id, :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = id
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

  def initialize(name)
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def check_out_book(book_id, borrower)
    @status = 'checked_out'
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
