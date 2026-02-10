using library.domain.contracts;
using library.domain.services;
using Microsoft.AspNetCore.Mvc;

namespace library.api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BookController : Controller
    {
        private readonly IBookService _bookService;

        public BookController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpPost()]
        public async Task<IActionResult> Post([FromBody] BookDto book)
        {
                var createdBook = await _bookService.CreateAsync(book);

                return CreatedAtAction(nameof(GetById), new { id = createdBook.Id }, createdBook);

        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(string id)
        {
            return Ok(await _bookService.GetAsync(id));
        }

        [HttpGet()]
        public IActionResult GetAll()
        {
            return Ok(_bookService.GetAll());

        }

        [HttpPut()]
        public async Task<IActionResult> Put([FromBody] BookDto book)
        {
            return Ok(await _bookService.UpdateAsync(book));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _bookService.DeleteAsync(id);

            return NoContent();
        }
    }
}
