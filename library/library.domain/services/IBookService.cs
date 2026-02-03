using library.domain.contracts;

namespace library.domain.services
{
    public interface IBookService
    {
        Task<BookDto> CreateAsync(BookDto book);
        Task<BookDto> GetAsync(string id);
        IEnumerable<BookDto> GetAll();
        Task<BookDto> UpdateAsync(BookDto book);
        Task DeleteAsync(string id);
    }
}
