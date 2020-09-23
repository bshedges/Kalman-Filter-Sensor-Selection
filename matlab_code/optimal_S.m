function S_opt = optimal_S(Q,A,C,W,V,B)

S_all = nchoosek(Q,B);

S_opt = 0;
tr_opt = 1000;
for i = 1:length(S_all)
    Sig = cov_matrix(S_all(i,:),A,W,V,C);
    tr = trace(Sig);
    if tr <= tr_opt
        tr_opt = tr;
        S_opt = S_all(i,:);
    end
end
