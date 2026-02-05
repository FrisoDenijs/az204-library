using library.domain.contracts;
using library.domain.services;
using Microsoft.AspNetCore.Mvc;

namespace library.api.Controllers
{
    [ApiController]
    [Route("/books/")]
    public class BookController : Controller
    {
        private readonly IBookService _bookService;

        public BookController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpPost("/")]
        public async Task<IActionResult> PostAsync([FromBody] BookDto book)
        {
            return Ok(await _bookService.CreateAsync(book));
        }

        [HttpGet("/{id}")]
        public async Task<IActionResult> GetAsync(string id) 
        {
            return Ok(await _bookService.GetAsync(id));
        }

        [HttpGet("/")]
        public IActionResult GetAll() 
        { 
            return Ok(_bookService.GetAll());

        }

        [HttpPut("/")]
        public async Task<IActionResult> PutAsync([FromBody] BookDto book) 
        {
            return Ok(await _bookService.UpdateAsync(book));
        }

        [HttpDelete("/{id}")]
        public async Task<IActionResult> DeleteAsync(string id) 
        {
            await _bookService.DeleteAsync(id);

            return NoContent();
        }
    }
}
