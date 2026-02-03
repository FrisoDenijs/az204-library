using library.dal;
using library.domain.contracts;
using Microsoft.EntityFrameworkCore;

namespace library.domain.services
{
    public class BookService : IBookService
    {
        private readonly IDbContextFactory<LibraryContext> _contextFactory;

        public BookService(IDbContextFactory<LibraryContext> contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<BookDto> CreateAsync(BookDto book)
        {
            using var context = _contextFactory.CreateDbContext();

            var entry = context.Books.Add(new Book
            {
                Name = book.Name,
                Genre = book.Genre,
                Author = book.Author,
            });

            await context.SaveChangesAsync();

            var entity = entry.Entity;

            return new BookDto ( entity.Id, entity.Name, entity.Genre, entity.Author );
        }

        public async Task DeleteAsync(string id)
        {
            using var context = _contextFactory.CreateDbContext();

            var entity = await context.Books.SingleAsync(b =>  b.Id == id);

            context.Remove(entity);

            await context.SaveChangesAsync();  

            return;
        }

        public IEnumerable<BookDto> GetAll()
        {
            using var context = _contextFactory.CreateDbContext();

            return context.Books.Select(b => new BookDto ( b.Id, b.Name, b.Genre, b.Author ));
        }

        public async Task<BookDto> GetAsync(string id)
        {

            using var context = _contextFactory.CreateDbContext();

            var entity = await context.Books.SingleAsync(b => b.Id == id)!;

            return new BookDto (entity.Id, entity.Name, entity.Genre, entity.Author );
        }

        public async Task<BookDto> UpdateAsync(BookDto book)
        {
            using var context = _contextFactory.CreateDbContext();

            var entity = await context.Books.SingleAsync(b => b.Id == book.Id)!;

            entity.Author = book.Author;
            entity.Genre  = book.Genre;
            entity.Name = book.Name;

            var entry = context.Books.Update(entity);

            await context.SaveChangesAsync();

            return new BookDto ( entity.Id, entity.Name, entity.Genre, entity.Author );
        }
    }
}
