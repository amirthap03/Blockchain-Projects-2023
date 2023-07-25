// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BookLibrary {
    // Structure for book details
    struct Book {
        string title;
        string author;
        string publisher;
        uint256 year;
        address owner;
    }

    // List of books
    mapping(uint256 => Book) public books;

    // Number of books
    uint256 public bookCount;

    // Event for book creation
    event bookCreated(
        uint256 indexed id,
        string title,
        string author,
        string publisher,
        uint256 year,
        address owner
    );

    // Event for book ownership transfer
    event bookTransferred(
        uint256 indexed id,
        address from,
        address to
    );

    // Function to add book
    function addBook(
        string memory _title,
        string memory _author,
        string memory _publisher,
        uint256 _year
    ) public {
        bookCount++;
        books[bookCount] = Book(
            _title,
            _author,
            _publisher,
            _year,
            msg.sender
        );
        emit bookCreated(
            bookCount,
            _title,
            _author,
            _publisher,
            _year,
            msg.sender
        );
    }

    // Function to get book details
    function getBook(uint256 _id)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            uint256,
            address
        )
    {
        Book memory book = books[_id];
        return (book.title, book.author, book.publisher, book.year, book.owner);
    }

    // Function to transfer book ownership
    function transferBookOwnership(uint256 _id, address _newOwner) public {
        Book storage book = books[_id];
        require(msg.sender == book.owner, "Only the current owner can transfer ownership");
        require(_newOwner != address(0), "Invalid new owner address");
        book.owner = _newOwner;
        emit bookTransferred(_id, msg.sender, _newOwner);
    }
}
