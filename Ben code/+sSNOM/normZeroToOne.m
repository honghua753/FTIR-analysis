function Yn = normZeroToOne(Y)
Yn = Y-min(Y);
Yn = Yn./max(Yn);
end