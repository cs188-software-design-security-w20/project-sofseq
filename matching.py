

def mentor_from_same_country(country_of_origin, mentors_list):
    '''
    Checks if any mentor is from the same country. 
    Returns boolean.
    '''
    for mentor in mentors_list:
        if mentor[0] == country_of_origin:
            return True
    return False

def find_mentor(mentee_profile):
    '''
    Main driver function to 
    '''
    return None

def main():
    # All users are saved as a tuple -> (country of origin, languages spoken, goals, bio)
    mentors_list = [

            ]
    mentees_list = [

            ]
    for mentee in mentees_list:
        # Match order: 
        match = find_mentor(mentee)
        print(match)

if __name__ == "__main__":
    main()