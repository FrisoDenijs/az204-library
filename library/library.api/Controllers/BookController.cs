using library.domain.contracts;
using library.domain.services;
using Microsoft.AspNetCore.Mvc;

namespace library.api.Controllers
{
    public class BookController : Controller
    {
        private readonly IBookService _bookService;

        public BookController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpPost]
        public IActionResult Post(BookDto book)
        {
            return Ok(_bookService.Create(book));
        }

        [HttpGet]
        public IActionResult Get(string id) 
        {
            return Ok(_bookService.Get(id));
        }

        [HttpGet]
        public IActionResult Get() 
        { 
            return Ok(_bookService.GetAll());

        }

        [HttpPut]
        public IActionResult Put(BookDto book) 
        {
            return Ok(_bookService.Update(book));
        }

        [HttpDelete]
        public IActionResult Delete(string id) 
        {
            _bookService.Delete(id);

            return Accepted();
        }
    }
}
