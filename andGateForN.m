#	AND GATE
#   | x1 | x2 | output |
#    ------------------
#   | -1 | -1 |  -1    |
#   | -1 |  1 |  -1    |
#   |  1 | -1 |  -1    |
#   |  1 |  1 |   1    |		
#
# bias wieght always set to -1
# 

N = 2
numberOfEpocs = 5;
learningFactor = 0.2;
Weights = 2 * rand(1, N + 1) - 1

#TrainingInputs = [-1, 1, -1; -1, 1, 1];
#TrainingOutputs = [-1; 1];
trainingQuantity = 2;

Input = zeros(N + 1, 1);
Input(1, 1) = -1;
sum = 0;

for epoc = 1 : numberOfEpocs
	for row = 1 : trainingQuantity
		sum = 0;
		for i = 2 : N + 1
			Input(i, 1) = sign(rand() - 0.5);
			sum = sum + Input(i, 1);
		endfor
		if(sum == N)
			expectedOutput = 1;
		else
			expectedOutput = -1;
		endif	
		output = sign(Weights * Input);
		
		if(output != expectedOutput)
			#should correct weights
			for i = 1 : N + 1
				Weights(1, i) = Weights(1, i) + learningFactor * (1 - expectedOutput * output) * expectedOutput * Input(i, 1);
			endfor
		endif
	endfor
endfor

Weights

#######################################################################
printf("Testing with resulting Weights:\n");
testQuantity = 1000;
failedTests = 0;

for row = 1 : testQuantity
	sum = 0;
	for i = 2 : N + 1
		Input(i, 1) = sign(rand() - 0.5);
		sum = sum + Input(i, 1);
	endfor
	if(sum == N)
		expectedOutput = 1;
	else
		expectedOutput = -1;
	endif		
	output = sign(Weights * Input);
	
	if(output != expectedOutput)
		failedTests = failedTests + 1;
	endif
endfor

testQuantity
failedTests