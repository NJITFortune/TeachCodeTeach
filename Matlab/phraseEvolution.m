clear all

%% Settings

% How many variants to show
numVariantsDisplay = 10;

mutationRate = 0.0125;
outOf = 100000;

numOffspring = 10000;
generations = 2;
Selection = [];

animal = 17:19;
object = 42:45;

%% Genetic Code

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

%% Setup the phrase

geeNumOriginalCode = [1,1,1,4,1,1,1,1,1,4,1,1,1,1,1,3,4,4,4,3,1,1,1,1,1,1,4,1,1,1,1,4,1,1,1,4,1,1,1,1,3,1,4,1,4];
geeGnome = translategNum(geeNumOriginalCode, lookup);

for j=numOffspring:-1:1
    mutatedGnome(j,:) = translategNum(mutateSeq(geeNumOriginalCode, mutationRate, outOf),lookup);
end

IDX = selectorFunction(mutatedGnome, animal, 'fox', 1);

mutatedGnome(IDX(randi([1 length(IDX)], 1, numVariantsDisplay)),:)
length(IDX) / numOffspring


%% Translate
function geeOut = translategNum(geeNumIn, lookupSeq)

    for j=1:length(geeNumIn)
        geeOut(j) = lookupSeq(j,geeNumIn(j));
    end

end

%% Mutate
function newSeq = mutateSeq(oldSeq, mutateRate, outOfnum)

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

    numberOfOthers = round(length(survivorsIDX) - (length(survivorsIDX) * selectionStrength))

    if numberOfOthers > 0

        if length(survivorsIDX) < length(currGenome)
            extraIDXs = find(1:length(currGenome) ~= survivorsIDX', numberOfOthers);
            survivorsIDX = sort([survivorsIDX, extraIDXs']);
        end

    end

end