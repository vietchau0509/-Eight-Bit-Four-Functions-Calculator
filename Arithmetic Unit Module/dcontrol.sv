module dcontrol (
    input Clock, //active-high clock
    input Start, // start pulse
    input Rsign, // sign from alu op
    output AddSub, // select add/subtract
    output Dload, // enable load D register
    output Rload, // enable load R register
    output Qload, // enable load Q register
    output Rshift, // enable R reg shift
    output Qshift, // enable Q reg shift
    output DONE, // algorithm done indicator
    output Qbit //
);

// State definitions
parameter Inits = 4'h0;
parameter Adds = 4'h1;
parameter Subs1 = 4'h2;
parameter Subs = 4'h3;
parameter Shifts1 = 4'h4;
parameter Shifts2 = 4'h5;
parameter Shifts3 = 4'h6;
parameter Shifts4 = 4'h7;
parameter Restore = 4'h8;
parameter Ends = 4'h9;

reg [3:0] State;
reg [2:0] Count;

// decode state variable for Moore model outputs
assign Rload = ((State == Inits) || (State == Subs1) || (State == Subs) || (State == Adds) || (State == Restore)) ? 1'b1 : 1'b0;
assign Dload = (State == Inits) ? 1'b1 : 1'b0;
assign Qload = (State == Inits) ? 1'b1 : 1'b0;
assign AddSub = ((State == Adds) || (State == Restore)) ? 1'b0 : 1'b1;
assign Rshift = ((State == Shifts1) || (State == Shifts2)) ? 1'b1 : 1'b0;
assign Qshift = ((State == Shifts1) || (State == Shifts2) || (State == Shifts3) || (State == Shifts4)) ? 1'b1 : 1'b0;
assign Qbit = ((State == Shifts1) || (State == Shifts3)) ? 1'b0 : 1'b1;
assign DONE = (State == Ends) ? 1'b1 : 1'b0;

// counter for number of iterations
initial State = Inits;

always @(posedge Clock)
begin
    if (State == Inits)
        Count = 0;
    else if ((State == Shifts1) || (State == Shifts2))
    begin
        if (Count == 7)
            Count = 0;
        else
            Count = Count + 1;
    end
end

// state transitions
always @(posedge Clock) begin
    case (State)
        Ends:
            if (Start == 1'b1) 
                State = Inits;
            else 
                State = Ends;

        Inits: 
            State = Subs1;

        Subs1:
            if (Rsign == 1'b1) 
                State = Shifts1;
            else 
                State = Shifts2;

        Subs:
            if (Count == 0) 
            begin 
                if (Rsign == 1'b0) 
                    State = Shifts4; 
                else
                    State = Restore;
            end
            else if (Rsign == 1'b1) 
                State = Shifts1;
            else 
                State = Shifts2;

        Adds:
            if (Count == 0) 
            begin 
                if (Rsign == 1'b0) 
                    State = Shifts4; 
                else 
                    State = Restore; 
            end
            else if (Rsign == 1'b1) 
                State = Shifts1; 
            else 
                State = Shifts2;

        Shifts1: 
            State = Adds;

        Shifts2: 
            State = Subs;

        Shifts3: 
            State = Ends;

        Shifts4: 
            State = Ends;

        Restore: 
            State = Shifts3;

    endcase
end

endmodule
