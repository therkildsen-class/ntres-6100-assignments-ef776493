# AI_log


# \# Assignment 9: AI Use Log

## Question 1.2

1.  Tool(s) used: Copilot R integration

2.  Prompt(s): paste exact prompt(s) used

- Allowed “f_to_c_message” to autocomplete using the prompt in question
  1.2

3.  AI output summary: brief summary, not full text

- Copilot autocompleted the code to create a function in question 1.2
  with a series of if / else statements for the function

4.  Edits made and rationale: what was changed, why, and what was
    learned

- I attempted this problem on my own and my code generated errors and
  only output the right value for the first question. Comparing my code
  to the one Copilot generated helped my understand the if else / else
  if syntax. Turns out I actually did it correctly, minus an issue with
  an assignment operator, but I was looking at the wrong value, so
  thought I had done it wrong. Didn’t need copilot after all!

5.  Verification: how correctness was checked (unit tests, small
    examples, benchmarks)

- I checked my updated code (after I had edited it based on comparisons
  with the copilot output) and then tested it using the checks given in
  the problem.

## Exercise 2

1.  Tool(s) used: Copilot R integration

2.  Prompt(s): paste exact prompt(s) used

- Allowed “unique_element(x,y)” to autocomplete function using the
  prompt in question 2

3.  AI output summary: brief summary, not full text

- Copilot autocompleted the code to create a function in question 2
  using setdiff statements.

4.  Edits made and rationale: what was changed, why, and what was
    learned

- I read the R webpage for setdiff but still didn’t really understand
  what it meant or how to use it. I knew conceptually what needed to
  happen though, to get the output, but I didn’t know the code to get
  there . After seeing the copilot code for the problem, I can follow
  the code logic, but I still do not totally understand what “setdiff”
  means.

5.  Verification: how correctness was checked (unit tests, small
    examples, benchmarks)

- I checked the code with the check given in the problem set and got the
  same output.

## Exercise 3

1.  Tool(s) used: ChatGPT

2.  Prompt(s): paste exact prompt(s) used mtcars_tbl \|\> reorder(model,
    mpg) \|\> factor(“cyl”, levels = c(“4”, “6”, “8”)) \|\> ggplot(aes(x
    = mpg, y = model)) + geom_point(color = cyl, size = hp) +
    xlim(10, 40) + labs(x = “Miles per gallon fuel consumption”, color =
    “Number of cylinders”, size = “Horsepower”) + theme_minimal() +
    theme(axis.text.y = element_blank()) + axis.line.y =
    element_blank())

3.  AI output summary: brief summary, not full text

- Troubleshooting errors in my code, clarifying how to make the “factor”
  and “reorder” functions to work properly.

4.  Edits made and rationale: what was changed, why, and what was
    learned

- Corrected factor and reorder functions. Figured out how to adjust the
  theme elements through troubleshooting with ChatGPT and looking at the
  ?theme on R.

5.  Verification: how correctness was checked (unit tests, small
    examples, benchmarks)

- Ran it a bunch of times, with a bunch of small edits until the plot
  matched the example!
