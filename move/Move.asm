// File name: Move.asm

// Runs an infinite loop that listens to the keyboard input.
// Draws a 16-by-16 square to the top left corner of the screen.
// When a key is pressed and released (any key), the rectangle is
// moved 16 pixels to the right.

// Challenge versions (please specify if you are doing one of these):
// (Only try these if they sound interesting to you.)
//   - Instead of moving in 16-pixel increments, move in 5-pixel increments.
//   - Instead of moving whenever a key is pressed and released,
//       move gradually while a key is pressed down. <-- doing this one


// Put your code here.

@16
D=A
@HEIGHT
M=D //ROW_WIDTH = 16
@32
D=A
@ROW_WIDTH //in bytes
M=D //ROW_WIDTH = 32
@x
M=-1 //x = -1
@counter
M=0 //counter = 0

(LOOP)
	@KBD
	D=M //D = KBD
	@RESET_COUNTER
	D;JEQ //reset counter if KBD == 0
		@counter
		MD=M+1 //counter++
		@32767
		D=D-A //D = counter - 32767
		@LOOP
		D;JNE //continue if counter != 32767

		@x
		MD=M+1 //x++
		@SKIP_CLEAR
		D;JEQ //don't clear previous square if creating the first one
			@row
			M=0 //row = 0
			@SCREEN
			D=A //D = &SCREEN
			@x
			D=D+M //D = &SCREEN + x
			D=D-1 //D = &SCREEN + x - 1
			@write_position
			M=D //write_position = &SCREEN + x - 1
			(CLEAR_LOOP)
				@row
				D=M //D = row
				@HEIGHT
				D=D-M //D = row - HEIGHT
				@SKIP_CLEAR
				D;JEQ //break if row == height

				@write_position
				A=M //A = write_position
				M=0 //*write_position = 0

				@row
				M=M+1 //row++
				@write_position
				D=M //D = write_position
				@ROW_WIDTH
				D=D+M //D = write_position + ROW_WIDTH
				@write_position
				M=D //write_position += ROW_WIDTH
				@CLEAR_LOOP
				0;JMP
		(SKIP_CLEAR)
		@row
		M=0 //row = 0
		@SCREEN
		D=A //D = &SCREEN
		@x
		D=D+M //D = &SCREEN + x
		@write_position
		M=D //write_position = &SCREEN + x
		(ROW_LOOP)
			@row
			D=M //D = row
			@HEIGHT
			D=D-M //D = row - HEIGHT
			@RESET_COUNTER
			D;JEQ //break if row == height

			@write_position
			A=M //A = write_position
			M=-1 //*write_position = -1

			@row
			M=M+1 //row++
			@write_position
			D=M //D = write_position
			@ROW_WIDTH
			D=D+M //D = write_position + ROW_WIDTH
			@write_position
			M=D //write_position += ROW_WIDTH
			@ROW_LOOP
			0;JMP
	(RESET_COUNTER)
		@counter
		M=0 //counter = 0
		@LOOP
		0;JMP