using library.domain.contracts;

namespace library.domain.services
{
    public interface IBookService
    {
        BookDto Create(BookDto book);
        BookDto Get(string id);
        IEnumerable<BookDto> GetAll();
        BookDto Update(BookDto book);
        void Delete(string id);
    }
}
