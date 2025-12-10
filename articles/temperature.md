# Temperature

## Growing degree-days

Growing degree day can be calculated in several ways:

- **Method A and B**: Linear
  $$GDD = \frac{\left( T_{max} + T_{min} \right)}{2} - T_{base}$$

Methods A and B differ in their way of handling daily minimum and
maximum air temperatures. In **method A**, the comparison to base
temperature occurs after calculating the average temperature whereas in
**method B**, the comparison to base temperature is made before
calculating average air temperature using the following rules
\[@mcmaster_growing_1997\]:

- if $T_{max} < T_{base}$ then, $T_{max} = T_{base}$
- if $T_{min} < T_{base}$ then, $T_{min} = T_{base}$

**That’s why, it’s important to specify the method used to calculate
GDD.**

- **Method C**: Triangle

- **Method D**: Trapezoidal

![Rate of develoment as function of temperature for different growing
degree-days (GDD)
methods.](temperature_files/figure-html/rate-of-development-1.png)

Rate of develoment as function of temperature for different growing
degree-days (GDD) methods.

![Cumulative growing degree-days (GDD) calculated with different
methods.](temperature_files/figure-html/growing-degree-days-1.png)

Cumulative growing degree-days (GDD) calculated with different methods.

## References
