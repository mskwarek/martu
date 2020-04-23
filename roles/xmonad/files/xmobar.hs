
Config {
      font     = "xft:Hack:size=11:antialias=true"
    , bgColor = "black"
	, fgColor = "grey"
	--, position = TopW L 90
	, lowerOnStart = True
	, commands = [ Run Weather "KVIH" ["-t"," <tempF>°F","-L","64","-H","77","--normal","green","--high","red","--low","lightblue"] 36000
			, Run Network "eth0" ["-L","0","-H","32","--normal","green","--high","red"] 10
			, Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
			, Run Memory ["-t","Mem: <usedratio>%"] 10
			, Run Swap [] 10
			, Run Date "%a %b %_d %l:%M:%S" "date" 10
			, Run StdinReader
			]
	, sepChar = "%"
	, alignSep = "}{"
	, template = "%StdinReader% }{ %cpu% | %memory% * %swap%     %date%"
	}
