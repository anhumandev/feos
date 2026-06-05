import std.stdio;
import std.regex;
import std.file;
import std.string;
import core.stdc.stdlib;
import std.conv;

void main(string[] args){
string fill;

	if (args.length < 2){
		writeln("\033[1m\033[31mFEL: Faild to get.");
		exit(0);
	} else if (exists(args[1] ~ ".fel")){
		//auto jajd = readText(args[1] ~ ".fel");
		
		auto aa = File(args[1] ~ ".fel", "r");
		foreach(lal; aa.byLine()){
			auto aj = lal.idup;
			if (aj.startsWith("#x16")){
				// aj = aj.replace("#x16", "[BITS 16]");
				fill = fill ~ "\n" ~ "[BITS 16]";
			} else if (aj.startsWith("#location_in_ram")){
				auto jaj = regex(`\#location_in_ram (\S+)`);
				auto jaaa = match(aj, jaj);
				if (!jaaa.empty){
					// aj = aj.replace("#location_in_ram " ~ jaaa.captures[1], "[org " ~ jaaa.captures[1] ~ "]");
					fill = fill ~ "\n" ~ "[org " ~ jaaa.captures[1] ~ "]";
				} else {
					writeln("\033[1m\033[31mError during make files:\033[0m\033[1m location_in_ram need a value.");
					exit(0);
				}
			} else if (aj.startsWith("low")){
				auto aik = regex(`low (\S+) \@(\S+) \= (\S+) (\S+)`);
				auto hja = match(aj, aik);
				if (!hja.empty){
						if (hja.captures[2] == "PUT" || hja.captures[2] == "MOV"){
							if (hja.captures[3] == "low"){
								// aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l");
								try {
									int inty = to!int(hja.captures[4]);
									fill = fill ~ "\n" ~ "mov " ~ hja.captures[1] ~ "l, " ~ "0x" ~ hja.captures[4];
								} catch (Exception e){
									fill = fill ~ "\n" ~ "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l";
								}
								
							} else if (hja.captures[3] == "high"){
								//aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h");
								fill = fill ~ "\n" ~ "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h";
							} else {
								writeln("\033[1m\033[31mError during make files:\033[0m\033[1m just \"high\" or \"low\" allowed.");
								exit(0);
							}
						} else if (hja.captures[2] == "ADD"){
								if (hja.captures[3] == "low"){
								// aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l");
								fill = fill ~ "\n" ~ "add " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l";
							} else if (hja.captures[3] == "high"){
								//aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h");
								fill = fill ~ "\n" ~ "add " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h";
							} else {
								writeln("\033[1m\033[31mError during make files:\033[0m\033[1m just \"high\" or \"low\" allowed.");
								exit(0);
							}
						} else if (hja.captures[2] == "SUB"){
								if (hja.captures[3] == "low"){
								// aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l");
								fill = fill ~ "\n" ~ "sub " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l";
							} else if (hja.captures[3] == "high"){
								//aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h");
								fill = fill ~ "\n" ~ "sub " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h";
							} else {
								writeln("\033[1m\033[31mError during make files:\033[0m\033[1m just \"high\" or \"low\" allowed.");
								exit(0);
							}
						} else if (hja.captures[2] == "AND"){
								if (hja.captures[3] == "low"){
								// aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l");
								fill = fill ~ "\n" ~ "and " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "l";
							} else if (hja.captures[3] == "high"){
								//aj = aj.replace("low " ~ hja.captures[1] ~ " @put = " ~ hja.captures[3], "mov " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h");
								fill = fill ~ "\n" ~ "and " ~ hja.captures[1] ~ "l, " ~ hja.captures[4] ~ "h";
							} else {
								writeln("\033[1m\033[31mError during make files:\033[0m\033[1m just \"high\" or \"low\" allowed.");
								exit(0);
							}
						}
				} else {
					writeln("\033[1m\033[31mError during make files:\033[0m\033[1m Syntex wrong.");
					exit(0);
				}
			} else if (aj.startsWith("#end_of_felprog")){
				aj = aj.replace("#end_of_felprog", "");
				fill = fill ~ "\n" ~ aj;
				if (fill.indexOf("##") != -1){
					auto aja = regex(`\#\# (\S+) (\S+)`);
					auto ha = match(fill, aja);
					if (!ha.empty){
						fill = fill.replace("*" ~ ha.captures[1], ha.captures[2]);
						fill = fill ~ "\n" ~ aj;
					} else {
						writeln("\033[1m\033[31mError during make files:\033[0m\033[1m Faild Syntex.");
						exit(0);
					}
				}
				auto jka = File(args[1] ~ ".asm", "w");
				jka.write(fill);
				jka.close();
			} 
		}
	}

}
