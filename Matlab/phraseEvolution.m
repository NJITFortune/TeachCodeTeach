[animal, object, lookup, geeNumOriginalCode] = setUpGeneticCodes;

%% User Settings

% How many variants to show
numVariantsDisplay = 5;

% Mutation rate per generation per letter (probability of changing)
    mutationRate = 0.1;

% How many offsrping per generation    
    numOffspring = 10000;

% Original: fox  Variants: dog cow cat bat fax bot box fog fix
% Original: moon Variants: roof rope pope pole mole rail pail mail tape toll tale tool peon
selectedPhrase = 'fog';


%% System settings

% How many generations
    numGenerations = 1;
% How strong is selection?
    selectionStrength = 1;

    outOf = 100000; % Probably do not change this value

if length(selectedPhrase) == 3
    phraseLocation = animal;
    otherPhrase = translategNum(geeNumOriginalCode,lookup);
    otherPhrase = otherPhrase(object);
end
if length(selectedPhrase) == 4
    phraseLocation = object;
    otherPhrase = translategNum(geeNumOriginalCode,lookup);
    otherPhrase = otherPhrase(animal);
end

%% Mutate

for g = 1:numGenerations

for j=numOffspring:-1:1
    mutatedCode(j,:) = mutateSeq(geeNumOriginalCode, mutationRate, outOf);
    mutatedGnome(j,:) = translategNum(mutatedCode(j,:),lookup);
end
    [~, UniqueVariantsIDX] = unique(string(mutatedGnome(:, phraseLocation)));

IDX = selectorFunction(mutatedGnome, animal, selectedPhrase, 1);
    nonIDX = setdiff(1:length(mutatedGnome), IDX);

fprintf('Generation: %i \n', g);
fprintf('Produced %i offspring: %i had the selected trait %s.\n', numOffspring, length(IDX), selectedPhrase);
fprintf('%i were not selected with a total of %i variations.\n', numOffspring - length(IDX), length(UniqueVariantsIDX));
fprintf('The other trait started as %s \n', otherPhrase)
fprintf('Survivors: \n')
    if ~isempty(IDX)
        mutatedGnome(IDX(randi([1 length(IDX)], 1, min([length(IDX), numVariantsDisplay]))),:)
    else
        fprintf('There were no survivors.\n')
    end
fprintf('Non-surivors: \n')
    if ~isempty(nonIDX)
        mutatedGnome(nonIDX(randi([1 length(nonIDX)], 1, numVariantsDisplay)),:)    
    else
        fprintf('Everyone surivived.\n')
    end
end


%% Genetic Code
function [animal, object, lookup, geeNumOriginalCode] = setUpGeneticCodes
animal = 17:19;
object = 42:45;

lookup(1,:) = 'tpcb';
lookup(2,:) = 'hoae';
lookup(3,:) = 'epmt';
    lookup(4,:) = '    ';
lookup(5,:) = 'qwer';
lookup(6,:) = 'uiop';
lookup(7,:) = 'isdf';
lookup(8,:) = 'ctyu';
lookup(9,:) = 'kmnb';
    lookup(10,:) = '    ';
lookup(11,:) = 'basd';
lookup(12,:) = 'rtyu';
lookup(13,:) = 'opwe';
lookup(14,:) = 'wert';
lookup(15,:) = 'nmcv';
    lookup(16,:) = '    ';
% fox dog cow cat bat fax bot box fog fix
lookup(17,:) = 'bcdf';
lookup(18,:) = 'aeio';
lookup(19,:) = 'gtwx';
    lookup(20,:) = '    ';
lookup(21,:) = 'jasd';
lookup(22,:) = 'utyu';
lookup(23,:) = 'mpwe';
lookup(24,:) = 'pert';
lookup(25,:) = 'emcv';
lookup(26,:) = 'dmcv';
    lookup(27,:) = '    ';
lookup(28,:) = 'ower';
lookup(29,:) = 'viop';
lookup(30,:) = 'esdf';
lookup(31,:) = 'rtyu';
    lookup(32,:) = '    ';
lookup(33,:) = 'tpcb';
lookup(34,:) = 'hoae';
lookup(35,:) = 'epmt';
    lookup(36,:) = '    ';
lookup(37,:) = 'lwer';
lookup(38,:) = 'aiop';
lookup(39,:) = 'zsdf';
lookup(40,:) = 'ytxu';
    lookup(41,:) = '    ';
% moon roof rope pope pole mole rail pail mail tape toll tale tool peon
lookup(42,:) = 'mprt';
lookup(43,:) = 'aeio';
lookup(44,:) = 'opli';
lookup(45,:) = 'efln';

geeNumOriginalCode = [1,1,1,4,1,1,1,1,1,4,1,1,1,1,1,3,4,4,4,3,1,1,1,1,1,1,4,1,1,1,1,4,1,1,1,4,1,1,1,1,3,1,4,1,4];
geeGnomeOriginal = translategNum(geeNumOriginalCode, lookup);

fprintf('The original Phrase is:\n')
geeGnomeOriginal

end


%% Translate
function geeOut = translategNum(geeNumIn, lookupSeq)

    for j=1:length(geeNumIn)
        geeOut(j) = lookupSeq(j,geeNumIn(j));
    end

end

%% Mutate
function newSeq = (oldSeq, mutateRate, outOfnum)

newSeq = oldSeq;

    mutateOrNot = randi([1 outOfnum],1,45);
    randSeq = randi([1 4],1,45);

    thresh = outOfnum * mutateRate;

    newSeq(mutateOrNot <= thresh) = randSeq(mutateOrNot <= thresh);

end


%% Selection
function survivorsIDX = selectorFunction(currGenome, searchidxs, seq, selectionStrength)

    survivorsIDX = []; 
    for j = length(currGenome):-1:1
        if currGenome(j,searchidxs) == seq
            survivorsIDX(end+1) = j;
        end
    end

    numberOfOthers = round(length(survivorsIDX) - (length(survivorsIDX) * selectionStrength));

    if numberOfOthers > 0

        if length(survivorsIDX) < length(currGenome)
            extraIDXs = find(1:length(currGenome) ~= survivorsIDX', numberOfOthers);
            survivorsIDX = sort([survivorsIDX, extraIDXs']);
        end

    end

end