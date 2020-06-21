# 2nd milestone: Ruby Linter

In this project I've created a Ruby Linter which can detect and inform about different errors in a ruby file, those are:

1. Line has more than 100 characters

2. whitespace before or after parentheses, brackets, and braces

3. whitespace before or after an assignment operator

4. wrong indentation level

# Examples

- ``` x = [    1, 2] ``` will show an error <br />
but ``` x = [1, 2] ``` will not
 
- ```sum1 = 1 +  2``` will show an error <br />
but ```sum1 = 1 + 2``` will not

- ``` front = "something"``` will show an error <br />
```front = "something"```

## How to use

1. Download these files

2. open your terminal and type 
```ruby "type here the path to the main ruby file"```

3. after that, went prompted, introduce the path of the file you want to check, for testing purposes, there is a test file in which you can check that all the lint errors work properly

## Built With

- Ruby, RSpec.

## Authors

👤 Ricardo Vera

- Github: [@ricardo123321](https://github.com/ricardo123321)
- Twitter: [@ricardo615920830](https://twitter.com/ricardo615920830)
- Linkedin: [linkedin](https://www.linkedin.com/in/ricardo-vera-7381a81a2/)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).
