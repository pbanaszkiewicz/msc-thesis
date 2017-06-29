"cad" zawiera projekt mechaniczny wykonany w SketchUp Make.

"mechanics" zawiera większość elementów pracy wykonanych za pomocą środowiska Matlab/Simulink (R2016b).
Wewnątrz można znaleźć:
- ball_and_beam.slx: model nieliniowy z zaimplementowanym regulatorem
- ball_and_beam_for_lin*: modele nieliniowe wykorzystane do linearyzacji (nr "3" jest najwłaściwszy)
- linear_beam.slx: model liniowy belki
- linear_model.slx: model liniowy
- linear_control.slx: model liniowy z regulacją
- pliki *.fig: zapisane pliki figur
- beam_linearization_controller.mat, lin_analysis_session3.mat, model_responses.mat: zapisane pliki z wynikami obliczeń i/lub symulacji
- trim_bab.m: wygenerowany przez Matlaba skrypt znajdujący punkt równowagi systemu "ball_and_beam_for_lin3"
- linearize_bab.m: wygenerowany przez Matlaba skrypt przeprowadzający linearyzację systemu "ball_and_beam_for_lin3" po znalezieniu punktu równowagi za pomocą "trim_bab"
- bab_lin3.mat: zapisane wyniki linearyzacji przeprowadzonej na modelu "ball_and_beam_for_lin3"
- optimize_bab_linearization.m: plik bazujący na skrypcie doktora Tutaja ("dr_Tutaj_script.m"), w którym następują transformacje modelu zlinearyzowanego do postaci kaskadowej
- calculate_cascade.m: obliczanie regulatorów w układzie kaskadowym, zwijanie systemu
- rozw_rown_reg_od_stanu.m: obliczanie wzorów na regulator od stanu belki (metoda lokowania wartości własnych)
- pozostałe pliki *.m: funkcje pomocnicze

Zalecana kolejność uruchamiania:
optimize_bab_linearization
 |
 v
calculate_cascade

I następnie według uznania, np. symulacja modelu zlinearyzowanego z dobranym regulatorem ("linear_control.slx") lub np. obliczanie regulatora z samostrojenia ("rozw_rown_reg_od_stanu.m")
