using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace library.dal
{
    [Index(nameof(Genre))]
    [Index(nameof(Author))]
    public class Book
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public required string Id { get; set; }

        [Required]
        public required string Name { get; set; }

        [Required]
        public required string Genre { get; set; }

        [Required]
        public required string Author { get; set; }
    }
}