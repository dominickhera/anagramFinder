with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
procedure solveJumble is
-- delcare variables here
-- type stringArray is array (positive range <>) of character;
type anagramArray is array (positive range <>) of unbounded_string;
-- type dictionary is array (positive range <>) of stringArray;
type jumbleArray is array (1..1000) of unbounded_string;
type dictionary is array (positive range <>) of unbounded_string;
type realAnagramArray is array (positive range <>) of unbounded_string;
	

	function inputJumble return jumbleArray is
	jumbleList : jumbleArray;
	test : unbounded_string;
	-- word: string(1..1_000);
	length: integer;
	-- count: integer := 0;
	-- last: natural; 
	begin
		put("how many words do you want to add to the jumble?"); new_line;
		Ada.Integer_Text_IO.get(length);
		for i in 1..length+1 loop
			
			get_line(test);
			jumbleList(i) := test;
			put("\> ");
		end loop;
		return jumbleList;
		-- return word(1..last);
	end inputJumble;

	function generateAnagram return integer is
	fillerInt: integer := 1;
	begin
		put("this shouldve generatedAnagrams but i procrastinated and forgot to make enough time to do this function");new_line;

		return fillerInt;
	end generateAnagram;
	

	function getFileLength return integer is
		fileLength : integer := 1;
		line : unbounded_string;
		infp : file_type;
	begin
		-- open(infp, in_file, "/usr/share/dict/words");
		open(infp, in_file, "/usr/share/dict/canadian-english-small");
		loop
			exit when end_of_file(infp);
			get_line(infp, line);
			fileLength := fileLength + 1;
		end loop;
		close(infp);
		return fileLength;
	end getFileLength;

	function buildLEXICON return dictionary is
		infp : file_type;
		k : integer := 1;
		fileLength : integer := getFileLength;
		-- line : string(1..80);
		line : unbounded_string;
		buildDictionary : dictionary(1..fileLength);
	begin
		-- buildDictionary := buildLEXICON;
		-- open(infp, in_file, "/usr/share/dict/words");
		open(infp, in_file, "/usr/share/dict/canadian-english-small");
		loop
			exit when end_of_file(infp);
			get_line(infp, line);
			-- put("line is: "); put(line); new_line;
			buildDictionary(k) := line;
			k := k + 1;
		end loop;
		-- put("file size is :");put(fileLength);new_line;
		k := 1;
		close(infp);

		return buildDictionary;
	end buildLEXICON;


	procedure swapChars(swapString: in out unbounded_string; charA: integer; charB: integer) is
		tempString: string := Ada.Strings.Unbounded.To_String(swapString);
		temp: string := tempString(charA..charA);
		A: string := tempString(charA..charA);
		B: string := tempString(charB..charB);
	begin

		A := tempString(charA..charA);
		B := tempString(charB..charB);
		tempString(charA..charA) := B;
		tempString(charB..charB) := temp;
		swapString := Ada.Strings.Unbounded.To_Unbounded_String(tempString);

	
	end swapChars;



	procedure anagramSearch(anagramFind: in out anagramArray; string: in out unbounded_string; beginNum: in out integer; endNum: in out integer) is
		intCount: integer := beginNum;
		endCount: integer := endNum;
		intTempNum: integer;
		intTempLength: integer := length(string);
		anagramArrayInt: integer := 1;
	begin
		if beginNum = intTempLength then
			-- put("word is ");put(string);new_line;
			-- endNum := 1;
			for k in 1..anagramFind'length loop
					exit when anagramFind(k) = "";
					anagramArrayInt := anagramArrayInt + 1;
				end loop;
			anagramFind(anagramArrayInt) := string;
			 -- put("word is ");put(anagramFind(anagramArrayInt));new_line;
			beginNum := 1;
		else

			for i in 1..length(string) loop
				-- put("word is ");put(string);new_line;

				swapChars(string, beginNum, i);
				intTempNum := beginNum + 1;
				-- if intTempNum = endNum then
				intTempLength := length(string) - 1;
				-- 	intTempNum := 1;
				-- end if;
				anagramSearch(anagramFind, string, intTempNum, intTempLength);
				swapChars(string, beginNum, i);


			end loop;
		end if;

	end anagramSearch;


	function findAnagram(realAnagramFind: in out realAnagramArray; anagramFind: in out anagramArray; dictionarySearch: in dictionary; jumbleSearch: in jumbleArray) return realAnagramArray is
		line: unbounded_string;
		beginNum: integer := 1;
		endNum: integer := 1;
		realWordCount: integer := 1;
	begin
		for i in 2..jumbleSearch'length loop
			exit when jumbleSearch(i) = "";
			line := jumbleSearch(i);
			for k in 1..length(line) loop
				-- exit when Element(line, k) = "";
				endNum := endNum * k;
				-- put("end num is "); put(k); new_line;
			end loop;
			-- put("end num is "); put(endNum); new_line;
			endNum := endNum - 1;
			anagramSearch(anagramFind, line, beginNum, endNum);
		end loop;

		for i in 2..dictionarySearch'length loop
			exit when dictionarySearch(i) = "";
			-- realWordCount := 1;
			for k in 2..anagramFind'length loop
			exit when anagramFind(k) = "";
				if anagramFind(k) = dictionarySearch(i) then
					realAnagramFind(realWordCount) := anagramFind(k);
					realWordCount := realWordCount + 1;
				end if;
			end loop;
		end loop;


	return realAnagramFind;
	end findAnagram;

	jumble : jumbleArray := inputJumble;
	wordDictionary : dictionary := buildLEXICON;
	anagramDictionary : anagramArray(1..10000);
	realWordsList: realAnagramArray(1..10000);
	fillerInt: integer := generateAnagram;
begin
	-- Put_Line("how many words do you want to enter?");
	-- Ada.Integer_Text_IO.get(length);
	for i in 2..jumble'length loop
		exit when jumble(i) = "";
		put("entered this word: "); put(jumble(i));new_line;
	end loop;

	realWordsList := findAnagram(realWordsList, anagramDictionary, wordDictionary, jumble);
	for i in 2..realWordsList'length loop
		exit when realWordsList(i) = "";
		put("anagrams found: ");put(realWordsList(i));new_line;
	end loop;
end solveJumble;