import "./Token" for Token
import "./TokenType" for TokenTypes

class Scanner {
	source { _source }
	tokens { _tokens }

	construct new(source){
		_source = source
		_start = 0
		_current = 0
		_line = 1

		_tokens = []
	}

	isAtEnd {
		return _current >= source.count
	}

	advance(){
		_current = _current + 1
		return _source[_current - 1]
	}
	
	addToken(type){
		addToken(type, null)
	}

	addToken(type, literal){
		var text = source[_start..._current]
		_tokens.add( Token.new(type, text, literal, _line) )
	}

	match(expected){
		if( isAtEnd ){
			return false
		}
		if( _source[_current] != expected ){
			return false
		}

		_current = _current + 1
		return true
	}

	peek(){
		if( _current >= _source.count ){
			return false
		} else {
			return _source[_current]
		}
	}

	scanToken(){
		var c = advance()
		
		/*no switch case, so using map matching to call a function*/
		var simpleMatch = ({
			" ": ( Fn.new { false } ),
			"\r": ( Fn.new { false } ),
			"\t": ( Fn.new { false } ),
			"\n": ( Fn.new {
				_line = _line + 1
				return false
			} ),

			"(": ( Fn.new { "LEFT_PAREN" } ),
			")": ( Fn.new { "RIGHT_PAREN" } ),
			"{": ( Fn.new { "LEFT_BRACE" } ),
			"}": ( Fn.new { "RIGHT_BRACE" } ),
			",": ( Fn.new { "COMMA" } ),
			".": ( Fn.new { "DOT" } ),
			"-": ( Fn.new { "MINUS" } ),
			"+": ( Fn.new { "PLUS" } ),
			";": ( Fn.new { "SEMICOLON" } ),
			"*": ( Fn.new { "STAR" } ),
			"!": ( Fn.new { match("=") ? "BANG_EQUAL" : "BANG" } ),
			"=": ( Fn.new { match("=") ? "EQUAL_EQUAL" : "EQUAL" } ),
			"<": ( Fn.new { match("=") ? "LESS_EQUAL" : "LESS" } ),
			">": ( Fn.new { match("=") ? "GREATER_EQUAL" : "GREATER" } ),

			"\"": ( Fn.new { string() } ),

			"/": ( Fn.new { 
				if( match("/") ){
					while( peek() != "\n" && !isAtEnd ){
						advance()
					}
					return false
				} else {
					return "SLASH"
				}
			} ),

		}[c])

		if( simpleMatch.type != Null ){
			var type = simpleMatch.call()
			System.print([c, type])
			if( type ){
				addToken( type )
			}
			return
		}
	
		/*need to find a way to deal with this circular import*/
		/*Lox.error(_line, "unexpected character")*/
	}

	scanTokens(){
		while( !isAtEnd ){
			_start = _current
			scanToken()
		}

		tokens.add( Token.new( "EOF", "", null, _line ) )
	}
}

var source = "//foo\n(/\n   )"
var scanner = Scanner.new( source )
scanner.scanTokens()

System.print(source)
for( token in scanner.tokens ){
	System.print(token)
}
