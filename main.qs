namespace QuantumHitAndRun {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;

    @EntryPoint()
    operation Main() : String {
        mutable s = "";
        set s += $"{RunFunction([[9], [2, 2], [2, 2]], [2.0, 2.3])}";
        Message(s);
        return s;
    }

    operation RandomNumber() : Int {
        mutable bits = [];
        use q = Qubit();

        for i in 1..8 {
            H(q);
            set bits += [M(q)];
            Reset(q);
        }
        let num = ResultArrayAs2sComplement(bits);

        return num;
    }

    operation CreateConvexFunction(d : Int) : Int[][] {
        mutable f = [[]];
        set f = [[RandomNumber()]];
        for i in 1..d {
            set f += [[RandomNumber(), AbsI(RandomNumber())]];
        }
        return f;
    }

    operation FindMin(f : Int[][]) : Int[] {
        mutable min = [];
        set min = [-f[1][0]];
        for i in 2..(Length(f) - 1) {
            set min += [-f[i][0]]
        }
        return min;
    }

    operation RunFunction(f : Int[][], x : Double[]) : Double {
        let length = Length(f);
        mutable y = IntAsDouble(f[0][0]);

        for i in 1..(length-1) {
            set y += IntAsDouble(f[i][1])*((x[i-1] + IntAsDouble(f[i][0]))^2.0);
        }

        return y;
    }

    operation QSimAnnealing(f : Int[][], e : Double) : Int{
        let n = IntAsDouble(Length(f));
        let K = Sqrt(n) * Log(n/e);

        

        return 1;
    }

    operation ResultArrayAs2sComplement(r : Result[]) : Int {
        mutable n = 0;
        let length = Length(r);

        set n -= ResultAsBool(r[0])? (2^(length - 1)) | 0;

        for i in 1..(length - 1) {
            set n += ResultAsBool(r[i])? (2^(length - 1 - i)) | 0;
        }

        return n;
    }

    operation Test() : String {
        return "a\na\na"
    }
}