# assignment_7


Assignment 7: Relational data plus revisiting data wrangling and
visualization ================

``` r
library(tidyverse)
library(knitr)
library(dslabs) #install.packages("dslabs")
```

## Excercise: 2016 election result and polling

For this exercise, we will explore the result of the 2016 US
presidential election as well as the polling data. We will use the
following three datasets in the `dslabs` package, and use `join`
function to connect them together. As a reminder, you can use `?` to
learn more about these datasets.

- `results_us_election_2016`: Election results (popular vote) and
  electoral college votes from the 2016 presidential election.

- `polls_us_election_2016`: Poll results from the 2016 presidential
  elections.

- `murders`: Gun murder data from FBI reports. It also contains the
  population of each state.

We will also use [this
dataset](https://raw.githubusercontent.com/kshaffer/election2016/master/2016ElectionResultsByState.csv)
to get the exact numbers of votes for question 3.

### Question 1. What is the relationship between the population size and the number of electoral votes each state has?

**1a.** Use a `join` function to combine the `murders` dataset, which
contains information on population size, and the
`results_us_election_2016` dataset, which contains information on the
number of electoral votes. Name this new dataset `q_1a`, and show its
first 6 rows.

``` r
head(murders)
```

           state abb region population total
    1    Alabama  AL  South    4779736   135
    2     Alaska  AK   West     710231    19
    3    Arizona  AZ   West    6392017   232
    4   Arkansas  AR  South    2915918    93
    5 California  CA   West   37253956  1257
    6   Colorado  CO   West    5029196    65

``` r
head(results_us_election_2016)
```

             state electoral_votes  clinton    trump  johnson     stein  mcmullin
    1   California              55 61.72640 31.61711 3.374092 1.9649200 0.2792070
    2        Texas              38 43.23526 52.23469 3.160719 0.7978169 0.4723485
    3      Florida              29 47.82332 49.02194 2.197900 0.6836384 0.0000000
    4     New York              29 59.00604 36.51559 2.287108 1.3978457 0.1343400
    5     Illinois              20 55.82537 38.76175 3.785765 1.3872131 0.2105149
    6 Pennsylvania              20 47.46495 48.18334 2.379621 0.8100102 0.1049716
          others
    1 1.03827531
    2 0.09917244
    3 0.27320481
    4 0.65907285
    5 0.02938720
    6 1.05711187

``` r
q_1a <- murders |> 
  full_join(results_us_election_2016)

head(q_1a) |> 
  kable()
```

| state | abb | region | population | total | electoral_votes | clinton | trump | johnson | stein | mcmullin | others |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Alabama | AL | South | 4779736 | 135 | 9 | 34.35795 | 62.08309 | 2.094169 | 0.4422682 | 0.0000000 | 1.0225246 |
| Alaska | AK | West | 710231 | 19 | 3 | 36.55087 | 51.28151 | 5.877128 | 1.8000176 | 0.0000000 | 4.4904710 |
| Arizona | AZ | West | 6392017 | 232 | 11 | 44.58042 | 48.08314 | 4.082188 | 1.3185997 | 0.6699155 | 1.2657329 |
| Arkansas | AR | South | 2915918 | 93 | 6 | 33.65190 | 60.57191 | 2.648769 | 0.8378174 | 1.1653206 | 1.1242832 |
| California | CA | West | 37253956 | 1257 | 55 | 61.72640 | 31.61711 | 3.374092 | 1.9649200 | 0.2792070 | 1.0382753 |
| Colorado | CO | West | 5029196 | 65 | 9 | 48.15651 | 43.25098 | 5.183748 | 1.3825031 | 1.0400874 | 0.9861714 |

**1b.** Add a new variable in the `q_1a` dataset to indicate which
candidate won in each state, and remove the columns `abb`, `region`, and
`total`. Name this new dataset `q_1b`, and show its first 6 rows.

``` r
q_1b <- q_1a |> 
  mutate(winner = ifelse(clinton >= 50,"clinton", "trump")) |> 
  select(-abb, -region, -total)

head(q_1b) |> 
  kable()
```

| state | population | electoral_votes | clinton | trump | johnson | stein | mcmullin | others | winner |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| Alabama | 4779736 | 9 | 34.35795 | 62.08309 | 2.094169 | 0.4422682 | 0.0000000 | 1.0225246 | trump |
| Alaska | 710231 | 3 | 36.55087 | 51.28151 | 5.877128 | 1.8000176 | 0.0000000 | 4.4904710 | trump |
| Arizona | 6392017 | 11 | 44.58042 | 48.08314 | 4.082188 | 1.3185997 | 0.6699155 | 1.2657329 | trump |
| Arkansas | 2915918 | 6 | 33.65190 | 60.57191 | 2.648769 | 0.8378174 | 1.1653206 | 1.1242832 | trump |
| California | 37253956 | 55 | 61.72640 | 31.61711 | 3.374092 | 1.9649200 | 0.2792070 | 1.0382753 | clinton |
| Colorado | 5029196 | 9 | 48.15651 | 43.25098 | 5.183748 | 1.3825031 | 1.0400874 | 0.9861714 | trump |

**1c.** Using the `q_1b` dataset, plot the relationship between
population size and number of electoral votes. Use color to indicate who
won the state. Fit a straight line to the data, set its color to black,
size to 0.1, and turn off its confidence interval.

``` r
q_1b |> 
  ggplot(mapping = aes(x = population, y = electoral_votes, color = winner)) + 
  geom_point() + 
  geom_smooth(color = "black", size = 0.1, se = FALSE)
```

![](assignment_7_files/figure-commonmark/unnamed-chunk-4-1.png)

### Question 2. Would the election result be any different if the number of electoral votes is exactly proportional to a state’s population size?

**2a.** First, convert the `q_1b` dataset to longer format such that the
`population` and `electoral_votes` columns are turned into rows as shown
below. Name this new dataset `q_2a`, and show its first 6 rows.

``` r
q_2a <- q_1b |> 
  pivot_longer(cols = c(population, electoral_votes), 
               names_to = "metric", 
               values_to = "value")
head(q_2a) |> 
  kable()
```

| state | clinton | trump | johnson | stein | mcmullin | others | winner | metric | value |
|:---|---:|---:|---:|---:|---:|---:|:---|:---|---:|
| Alabama | 34.35795 | 62.08309 | 2.094169 | 0.4422682 | 0.0000000 | 1.022525 | trump | population | 4779736 |
| Alabama | 34.35795 | 62.08309 | 2.094169 | 0.4422682 | 0.0000000 | 1.022525 | trump | electoral_votes | 9 |
| Alaska | 36.55087 | 51.28151 | 5.877128 | 1.8000176 | 0.0000000 | 4.490471 | trump | population | 710231 |
| Alaska | 36.55087 | 51.28151 | 5.877128 | 1.8000176 | 0.0000000 | 4.490471 | trump | electoral_votes | 3 |
| Arizona | 44.58042 | 48.08314 | 4.082188 | 1.3185997 | 0.6699155 | 1.265733 | trump | population | 6392017 |
| Arizona | 44.58042 | 48.08314 | 4.082188 | 1.3185997 | 0.6699155 | 1.265733 | trump | electoral_votes | 11 |

**2b.** Then, sum up the number of electoral votes and population size
across all states for each candidate. Name this new dataset `q_2b`, and
print it as shown below.

``` r
q_2b <- q_2a |>
  select(metric, winner, value) |>
  group_by(metric, winner) |>
  summarize(value = sum(value, na.rm = TRUE))

head(q_2b) |> 
  kable()
```

| metric          | winner  |     value |
|:----------------|:--------|----------:|
| electoral_votes | clinton |       183 |
| electoral_votes | trump   |       355 |
| population      | clinton | 109243742 |
| population      | trump   | 200620486 |

**2c.** Use the `q_2b` dataset to contruct a bar plot to show the final
electoral vote share under the scenarios of **1)** each state has the
number of electoral votes that it currently has, and **2)** each state
has the number of electoral votes that is exactly proportional to its
population size. Here, assume that for each state, the winner will take
all its electoral votes.

``` r
plot_2c_1 <- q_2b |> 
  filter(metric == "electoral_votes") |> 
  select(metric, winner, value) |> 
  ggplot(aes(x = winner, y = value)) + 
  geom_bar(stat = "identity")
plot_2c_1
```

![](assignment_7_files/figure-commonmark/unnamed-chunk-7-1.png)

``` r
plot_2c_2 <- q_2b |> 
  pivot_wider(
    names_from = metric,
    values_from = value) |> 
  mutate(proportion = population/electoral_votes) |> 
  ggplot(aes(x = winner, y = proportion)) +
  geom_bar(stat = "identity")

plot_2c_2
```

![](assignment_7_files/figure-commonmark/unnamed-chunk-8-1.png)

*Hint: `geom_col(position = "fill")` might be helpful.*

### Question 3. What if the election was determined by popular votes?

**3a.** First, from [this dataset on
GitHub](https://raw.githubusercontent.com/kshaffer/election2016/master/2016ElectionResultsByState.csv),
calculate the number of popular votes each candidate received as shown
below. Name this new dataset `q_3a`, and print it. <br>

*Note: Vote counts are listed for several other candidates. Please
combine the votes for all candidates other than Clinton and Trump into a
single `others` category (as shown in the table below)*

*Hint: `pivot_longer()` may be useful in here.*

``` r
q_3a <- read_csv("https://raw.githubusercontent.com/kshaffer/election2016/master/2016ElectionResultsByState.csv")

q_3a <- q_3a |> 
  select(-state, -postal, -clintonElectors, -trumpElectors, -totalVotes) |> 
  summarize(clinton = sum(clintonVotes),
            trump = sum(trumpVotes),
            others = sum(johnsonVotes + steinVotes + mcmullinVotes + othersVotes)) |> 
  mutate(metric = "popular_votes", .before = 1) |> 
  pivot_longer(cols = c(clinton, trump, others), 
               names_to = "winner")

kable(q_3a)
```

| metric        | winner  |    value |
|:--------------|:--------|---------:|
| popular_votes | clinton | 65125640 |
| popular_votes | trump   | 62616675 |
| popular_votes | others  |  7054974 |

**3b.** Combine the `q_2b` dataset with the `q_3a` dataset. Call this
new dataset `q_3b`, and print it as shown below.

``` r
q_3b <- q_2b |> 
  full_join(q_3a)

kable(q_3b)
```

| metric          | winner  |     value |
|:----------------|:--------|----------:|
| electoral_votes | clinton |       183 |
| electoral_votes | trump   |       355 |
| population      | clinton | 109243742 |
| population      | trump   | 200620486 |
| popular_votes   | clinton |  65125640 |
| popular_votes   | trump   |  62616675 |
| popular_votes   | others  |   7054974 |

**3c.** Lastly, use the `q_3b` dataset to contruct a bar plot to show
the final vote share under the scenarios of **1)** each state has the
number of electoral votes that it currently has, **2)** each state has
the number of electoral votes that is exactly proportional to its
population size, and **3)** the election result is determined by the
popular vote.

``` r
q_3b |> 
  group_by(metric) |> 
  mutate(proportion = value / sum(value)) |> 
  ggplot(aes(x = winner, y = proportion, fill = metric)) +
  geom_bar(stat = "identity", position = "stack")
```

![](assignment_7_files/figure-commonmark/unnamed-chunk-11-1.png)

### Question 4. The election result in 2016 came as a huge surprise to many people, especially given that most polls predicted Clinton would win before the election. Where did the polls get wrong?

**4a.** The polling data is stored in the data frame
`polls_us_election_2016`. For the sake of simplicity, we will only look
at the data from a single poll for each state. Subset the polling data
to include only the results from the pollster `Ipsos`. Exclude national
polls, and for each state, select the polling result with the `enddate`
closest to the election day (i.e. those with the lastest end date). Keep
only the columns `state`, `adjpoll_clinton`, and `adjpoll_trump`. Save
this new dataset as `q_4a`, and show its first 6 rows.

``` r
q_4a <- polls_us_election_2016 |> 
  filter(pollster == "Ipsos", state != "U.S.") |> 
  group_by(state) |> 
  slice_max(order_by = enddate, n = 1) |> 
  select(state, adjpoll_clinton, adjpoll_trump)

head(q_4a) |> 
  kable()
```

| state       | adjpoll_clinton | adjpoll_trump |
|:------------|----------------:|--------------:|
| Alabama     |        37.54023 |      53.69718 |
| Arizona     |        41.35774 |      46.17779 |
| Arkansas    |        37.15339 |      53.28384 |
| California  |        58.33806 |      31.00473 |
| Colorado    |        46.00764 |      40.73571 |
| Connecticut |        48.81810 |      38.87069 |

*Note: You should have 47 rows in `q_4a` because only 47 states were
polled at least once by Ipsos. You don’t need to worry about the 3
missing states and DC.*

*Hint: `group_by()` and `slice_max()` can be useful for this question.
Check out the help file for `slice_max()` for more info.*

**4b.** Combine the `q_4a` dataset with the `q_1b` dataset with a `join`
function. The resulting dataset should only have 47 rows. Create the
following new variables in this joined dataset.

- `polling_margin`: difference between `adjpoll_clinton` and
  `adjpoll_trump`
- `actual_margin`: difference between `clinton` and `trump`
- `polling_error`: difference between `polling_margin` and
  `actual_margin`
- `predicted_winner`: predicted winner based on `adjpoll_clinton` and
  `adjpoll_trump`
- `result = ifelse(winner == predicted_winner, "correct prediction", str_c("unexpected ", winner, " win"))`

Keep only the columns `state`, `polling_error`, `result`,
`electoral_votes`. Name the new dataset `q_4b` and show its first 6
rows.

``` r
q_4b <- q_4a |> 
  left_join(q_1b) |> 
  mutate(polling_margin = adjpoll_clinton - adjpoll_trump) |> 
  mutate(actual_margin = clinton - trump) |> 
  mutate(polling_error = polling_margin - actual_margin) |> 
  mutate(predicted_winner = ifelse(adjpoll_clinton > adjpoll_trump,"clinton", "trump")) |> 
  mutate(result = ifelse(
      winner == predicted_winner,
      "correct prediction",
      str_c("unexpected ", winner, " win")
    )
  ) |> 
  select(state, polling_error, result, electoral_votes)

head(q_4b) |> 
  kable()
```

| state       | polling_error | result               | electoral_votes |
|:------------|--------------:|:---------------------|----------------:|
| Alabama     |    11.5681966 | correct prediction   |               9 |
| Arizona     |    -1.3173239 | correct prediction   |              11 |
| Arkansas    |    10.7895518 | correct prediction   |               6 |
| California  |    -2.7759631 | correct prediction   |              55 |
| Colorado    |     0.3663946 | unexpected trump win |               9 |
| Connecticut |    -3.6919767 | correct prediction   |               7 |

**4c.** Generate the following plot with the `q_4b` dataset. Use chunk
options to adjust the dimensions of the plot to make it longer than the
default dimension. Based on this plot, where did the polls get wrong in
the 2016 election?

``` r
q_4b |> 
  ggplot(aes(x = polling_error, y = state, color = result, size = electoral_votes)) +
  geom_point()
```

![](assignment_7_files/figure-commonmark/unnamed-chunk-14-1.png)
