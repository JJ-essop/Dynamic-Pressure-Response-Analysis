function [complex_pressure_ratio, freqs] = Theory_1_1_1_FrequencySweep(tube_length, tube_radius, freqs)

    handles.T_s = 27 + 273.15; % Ambient temperature (K).
    handles.p_s = 101325; % Ambient pressure (Pa).
    handles.rho_s = handles.p_s/(287.058*handles.T_s); % Ambient density (kg/m^3).

    coeffs.c_p = 1000.*[3.7619E-07, -0.00017881, 1.024428571]; % (J/kgK = m^2/s^2K).
    coeffs.c_v = 1000.*[3.7619E-07, -0.00017881, 0.737428571]; % (J/kgK).
    coeffs.mu = (10^(-5)).*[-2.78973E-06, 0.006378107, 0.181836827]; % (kg/ms)
    coeffs.lambda = (10^(-2)).*[-3.24522E-06, 0.009688274, 0.009013008]; % (W/mK=J/msK, J=kgm^2/s^2).

    handles.gamma_s = polyval(coeffs.c_p,handles.T_s)/polyval(coeffs.c_v,handles.T_s);
    handles.a0_s = sqrt(handles.gamma_s*handles.p_s/handles.rho_s);
    handles.Pr_s = polyval(coeffs.c_p,handles.T_s)*polyval(coeffs.mu,handles.T_s)/polyval(coeffs.lambda,handles.T_s); %Prandtl number*gravitational constant.

    for m = 1:numel(freqs)

        handles.p_0_amp = handles.p_s*0.01; % Amplitude of pressure disturbance in (Pa).
        handles.p_0 = @(t,nu) handles.p_0_amp.*exp(1i.*nu.*t);
%             handles.p_0 = @(t,nu) handles.p_0_amp.*exp(1i.*nu.*t) + 0.5.*handles.p_0_amp.*exp(1i.*nu/5.*t) + 0.5.*handles.p_0_amp.*exp(1i.*nu/10.*t);

        % pressure measuring system as per experiemnmtal setup
        handles.L = [0.01 tube_length 0.01 0.013 0.006]; % Array of line lengths (m). First element will correspond to the entrance of first line, i.e. applied perturbation.
        handles.V_V = [0 0 0 0 4.668e-09]; % Array of volumes at the end of each line elemnt in L (m^3).
        handles.R = [0.0003 tube_radius 0.0003 0.00065 0.0004]; % Array of line radii for each element of L (m).
        handles.sigma = [0 0 0 0 0]; % Stiffness of diaphragm for transducer in each volume elemnt.
        handles.k_poly = [1 1 1 1 1];

        handles.N=numel(handles.L);
        if numel(handles.V_V)~=handles.N || numel(handles.R)~=handles.N || numel(handles.sigma)~=handles.N
            error('Number of elements in the arrays for volume, radius, diaphragm stiffness and line length must be the same')
            return
        end

        handles.p = cell(numel(handles.L),1);
        handles.alpha = cell(numel(handles.L),1);
        handles.n = cell(numel(handles.L),1);
        handles.phi = cell(numel(handles.L),1);
        handles.V_L = pi.*(handles.R.^2).*handles.L;

        for i = 1:numel(handles.L)
            handles.alpha{i} = @(nu) (1i^(3/2)).*handles.R(i).*sqrt(handles.rho_s.*nu./polyval(coeffs.mu,handles.T_s));
            handles.n{i} = @(nu) (1 + (((handles.gamma_s-1)./handles.gamma_s).*(besselj(2,(handles.alpha{i}(nu)).*sqrt(handles.Pr_s))./besselj(0,(handles.alpha{i}(nu)).*sqrt(handles.Pr_s))))).^(-1);
            handles.phi{i} = @(nu) (nu./handles.a0_s).*sqrt(besselj(0,handles.alpha{i}(nu))./besselj(2,handles.alpha{i}(nu))).*sqrt(handles.gamma_s./(handles.n{i}(nu)));
        end

        i=handles.N;
        handles.p{i} = @(nu) ( ( cosh((handles.phi{i}(nu)).*handles.L(i)) + ((handles.V_V(i)./handles.V_L(i)).*(handles.sigma(i)+(1/handles.k_poly(i))).*(handles.n{i}(nu)).*((handles.phi{i}(nu))).*handles.L(i).*sinh((handles.phi{i}(nu)).*handles.L(i))) ).^(-1) );
        if handles.N>1
            for i = handles.N-1:-1:1
                handles.p{i} = @(nu) ( ( cosh((handles.phi{i}(nu)).*handles.L(i)) + ((handles.V_V(i)./handles.V_L(i)).*(handles.sigma(i)+(1/handles.k_poly(i))).*(handles.n{i}(nu)).*((handles.phi{i}(nu))).*handles.L(i).*sinh((handles.phi{i}(nu)).*handles.L(i))) +...
                    (((handles.V_L(i+1)./handles.V_L(i)).*((handles.phi{i+1}(nu))./(handles.phi{i}(nu))).*(handles.L(i)./handles.L(i+1))).*(besselj(0,(handles.alpha{i}(nu)))./(besselj(0,(handles.alpha{i+1}(nu))))).*(besselj(2,(handles.alpha{i+1}(nu)))./(besselj(2,(handles.alpha{i}(nu))))).*(sinh((handles.phi{i}(nu)).*handles.L(i))./sinh((handles.phi{i+1}(nu)).*handles.L(i+1))).*(cosh((handles.phi{i+1}(nu)).*handles.L(i+1)) - handles.p{i+1}(nu))) ).^(-1) );
            end
        end

        handles.T_end = 1;
        handles.f_nat = freqs(m); % Perturbation frequency (Hz).
        handles.nu = 2*pi*handles.f_nat; % Perturbation frequency range (rad/s).

        handles.complex_pressure_ratio = 1;

        for i = handles.N:-1:1
            handles.complex_pressure_ratio = handles.complex_pressure_ratio.*handles.p{i}(handles.nu);
        end
        
        complex_pressure_ratio(m) = handles.complex_pressure_ratio;

    end
end

