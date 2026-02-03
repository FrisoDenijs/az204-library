using Microsoft.EntityFrameworkCore;

namespace library.dal
{
    public class LibraryContext : DbContext
    {
        public DbSet<Book>  Books { get; set; }
    }
}
