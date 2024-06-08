clear,clc

model = 'CLLC_2022';
load_system(model)
in = Simulink.SimulationInput(model);
in = in.setModelParameter('SimulationMode', 'rapid-accelerator');
in = in.setModelParameter('RapidAcceleratorUpToDateCheck', 'off');
FnSweep = 0.6:0.01:0.99;
RlSweep = 200:1:500;

for j = length(RlSweep):-1:1
    for i = length(FnSweep):-1:1
        in(i,j) = Simulink.SimulationInput('CLLC');
        in(i,j) = in(i,j).setVariable('fn',FnSweep(i));
        in(i,j) = in(i,j).setVariable("Rl",RlSweep(j));
    end
end
save("in_200_500_1","in")

out = parsim(in, 'ShowSimulationManager', 'on');
save("out_200_500_1","out")