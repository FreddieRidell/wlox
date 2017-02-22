import "./TokenType" for IsToken, TokenTypes

class Token {
	type { _type }
	lexeme { _lexeme }
	literal { _literal }
	line { _line }

	construct new(type, lexeme, literal, line){
		_type = type
		_lexeme = lexeme
		_literal = literal
		_line = line

		if(!IsToken.call(type)){
			Fiber.abort("%(type) is an invalid token type")
		}
	}

	toString {
		return "%(_type) %(_lexeme) %(_literal)"
	}
}
