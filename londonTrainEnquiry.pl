#!/usr/bin/perl

#/**
# * @author Priyank# *	@description: This is a basic program done to demonstrate how to make an eliza like program
#	using substitution in regex. This can be made more readable and compact by storing the regular expressions
#	as rules in a separate file.
# */

# This variable is incremented on letting the user know the reason for the delay in train service, 
# so that the user does not have to be notified of the reason in the subsequent questions.

$delayNotified = 0;

$delayReason = "This is due to the weather.";
$limitation = "I am doing fine, i am limited to responses only for technical questions.";
$limitationNotified = 0;
print "*******************************************************************\n";
print "*You can type in queries regarding the London train services here.*\n"; 
print "*You can stop the conversation by saying 'Bye'********************* \n";
print "*******************************************************************\n";

EXIT:
	while ($userInput = <STDIN>){
		
		if($delayNotified > 1){
			$delayReason = "This is due to an earlier incident";
		}
		if($limitationNotified > 0){
			$limitation = "I am limited to responses only for technical questions";
		}		
		if ($userInput =~ m/^(see|syou|cya|bye|goodbye|thank you|thanks|ok|okay)$/){
			print "Thank you for talking to London train services customer care :)\n";
			last EXIT;
		}else{

			if($userInput =~ /.*^(hi|hello|good morning|good evening)$.*/){
				$userInput =~ s/.*/Hello there/i;
			}elsif($userInput =~ m/.*^(how [are|r] [you|u]|how are)$.*/){
				$userInput =~ s/.*/$limitation./i;
				$limitationNotified = $limitationNotified + 1;
			}elsif ($userInput =~ /.*[iI] (would\slike|want|have) to go to ([\b\w\b]+) (this|today)\s?((afternoon|evening)?).*/){
				
				if($4){
					$userInput =~ s/.*I (would\slike|want|have) to go to ([\b\w\b]+) (this|today)\s?((afternoon|evening)?).*/Greater Anglia apologises for the delay of this $4's services. There is no train to $2 today this $4. $delayReason./i;
				}else{
					$userInput =~ s/.*I (would\slike|want|have) to go to ([\b\w\b]+) (this|today).*/Greater Anglia apologises for the delay in services. There is no train to $2 today. $delayReason./i;
				}
				$delayNotified = $delayNotified + 1;
			}elsif($userInput =~ m/.*[when|what]+.*to ([\b\w\b]+)/ || $userInput =~ m/.*(next train)/){
				$userInput =~ s/.*[when|what]+.*to ([\b\w\b]+)/Greater Anglia apologises for the delay in services. There is no train to $1 today. $delayReason./i;
				
			}elsif($userInput =~ m/.*[go to][\s\b]+([\w]+)\b.*/){
				$userInput =~ s/.*/When would you like to go?/i;
				$delayNotified = $delayNotified + 1;
				
			}elsif($userInput =~ /.*[\s\b]?(evening|today|morning|afternoon|now|night|hour|minutes|saturday|sunday|monday|tuesday|wednesday|thursday|friday|tomorrow)/){
				$userInput =~ s/.*[\s\b]?(evening|morning|afternoon|now|night|hour|minutes|tomorrow|day|after)/Greater Anglia apologises. There is no train available for the time that you have requested. $delayReason/i;
				$delayNotified = $delayNotified + 1;
			}else{
				$userInput = "Sorry, my responses are limited."
			}
			print "$userInput\n";
			
		}
		
	}