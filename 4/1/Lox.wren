import "os" for Process
import "io" for File, Stdin

class Lox {
	static main() {
		var args = Process.arguments
		if(args.count > 1){
			System.print("Usage: 'wren Lox.wren [script]")
		} else if(args.count == 1){
			runFile(args[0])
		} else {
			runPrompt()
		}
	}

	static runFile(path){
		run(File.read(path))

		if(__hadError){
			Fiber.abort("An Error Ocoured")
		}
	}

	static runPrompt(){
		while(true){
			System.print("> ")
			run(Stdin.readLine())
			__hadError = false
		}
	}

	static run(source){
		var scanner = Scanner.new(source)
		var tokens = scanner.scanTokens()

		//for now, just print the tokens:
		for(token in tokens){
			System.print(token)
		}
	}

	static error(line, message){
		report(line, "", message)
	}

	static report(line, where, message){
		System.print("[line %(line)] Error %(where): %(message)")
	}
}

Lox.main()
