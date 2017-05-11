/* grphtm.h */

// MIT License
//
// Copyright (c) 2017 softwaredev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

// char g_my_aspect_text[512];   // kkk
char g_my_aspect_text[4048];

struct g_aspect {
  char *g_asp_code;
  char *g_asp_text;
} g_asptab[] = {       //.co					 comp_mac_asp
  {"c01b01",  "There is a basic ego clash in your relationship and you have fundamentally different approaches in many areas."},
  {"c01b02",  "^^(B) sees ^^(A) as too bossy, while ^^(A) sees ^^(B) as too moody and sensitive."},
  {"c01b03",  "There are some communication difficulties in your relationship.  ^^(B) feels ^^(A) is too authoritarian, while ^^(A) feels ^^(B) is too changeable."},
  {"c01b04",  "There could be some money difficulties in the relationship. Also there are problems in emotional give and take."},
  {"c01b05",  "Impulsive behavior and temper flare-ups can cause a lot of trouble, especially from ^^(B)."},
  {"c01b06",  "^^(B) could lead the two of you into over-optimistic and  unrealistic projects.  Or, you could have disputes over religion or philosophy."},
  {"c01b07",  "The relationship will be subject to frequent frustrations, but you can succeed through very hard work.  There can be some difficulty in dealing with laws and rules of all kinds."},
  {"c01b08",  "^^(A) sees ^^(B) as having erratic behaviour or perverse  wrong-headedness.  Business relationships are extremely difficult."},
  {"c01b09",  "^^(A) sees ^^(B) as having an impractical fogginess which can lead to deception.  You will have many misunderstandings in the relationship."},
  {"c01b10",  "You have the classic indicator of a power struggle relationship.  There are plenty of money problems."},
  {"c01c01",  "You have your suns very close together, so you share the characteristics of your sun signs.  Beware if you are Aries or Leo because these two are assertive signs."},
  {"c01c02",  "You have an excellent compatibility indicator because ^^(Ap) sun is close to ^^(Bp) moon.  ^^(A) is likely to have a strong influence over ^^(B)."},
  {"c01c03",  "^^(A) is likely to stimulate ^^(Bp) thinking and there will be a lot of communication in the relationship."},
  {"c01c04",  "Your relationship can be cheerful and affectionate  and you could have joint interests in music or art.  You  will have fun together and you're both good with children. This is an excellent indicator of romantic attraction."},
  {"c01c05",  "Your relationship has high energy but ^^(Bp) self-assertion  can cause some conflicts."},
  {"c01c06",  "You are mutually kind and generous, especially ^^(B), and  can team up well in religion, law, travel or philosophy."},
  {"c01c07",  "Your relationship is on the serious side- which is good for business.  ^^(A) will see ^^(B) as too cool and unemotional but ^^(B) can help ^^(A) to be more disciplined and patience."},
  {"c01c08",  "You two could have a sudden magnetic attraction.  ^^(A) could regard ^^(B) as being too unpredictable and too independent."},
  {"c01c09",  "You have a strong intuitive link. ^^(A) will regard ^^(B) as being too vague or evasive."},
  {"c01c10",  "There could be a clash of wills.  ^^(B) could try to transform ^^(A).  It will take some doing to respect each other's freedom."},
  {"c01g01",  "You are naturally compatible since you have similar values and a harmonious relationship in general.  This is a very strong indicator."},
  {"c01g02",  "There is a very good indication between ^^(Ap) sun and ^^(Bp) moon which is an excellent indicator of compatibility."},
  {"c01g03",  "You have excellent communication between you, especially on ^^(Bp) part."},
  {"c01g04",  "You have a good indication for romantic compatibility.  You enjoy each other's company and share many interests, including children or show business.  In a business relationship dealings are favoured in entertainment, sports or luxury items."},
  {"c01g05",  "You work well together in things involving action or initiative.  Working together in trades, sports or engineering is favoured."},
  {"c01g06",  "You are mutually kind and generous and  can team up well in religion, law, travel or philosophy."},
  {"c01g07",  "Your relationship is on the serious side which is good for business.  ^^(A) will see ^^(B) as too cool and unemotional but ^^(B) can help ^^(A) to be more disciplined and patience."},
  {"c01g08",  "You two could have a sudden magnetic attraction.  You will share unusual interests."},
  {"c01g09",  "You could have a psychic link between you.  ^^(B) can bring creative imagination to ^^(A)."},
  {"c01g10",  "^^(B) can bring money to the relationship or the ability to turn a business around."},
  {"c02b01",  "^^(A) sees ^^(B) as too bossy, while ^^(B) sees ^^(A) as too moody and sensitive."},
  {"c02b02",  "There are emotional problems where each one cannot understand the other's feelings."},
  {"c02b03",  "There are problems in communicating about everyday matters.  Also a lot of time can be wasted in discussing unimportant things."},
  {"c02b04",  "There are various emotional misunderstandings between you. You can put too much emphasis on material things."},
  {"c02b05",  "There is an unfortunate situation where ^^(Bp) overly forceful actions can cause trouble and ^^(Ap) emotional weakness is painfully evident in comparison with ^^(B)."},
  {"c02b06",  "There can be family difficulties over religion.  In business, there needs to be a more practical approach."},
  {"c02b07",  "^^(Bp) moods can often be negative and great effort is needed to snap out of it.  The relationship often has numerous heavy burdens around it, especially around the home."},
  {"c02b08",  "^^(B) can have sudden big changes in mood and be impractical. ^^(B) will consider ^^(A) to be far too conservative."},
  {"c02b09",  "The relationship is subject to emotional confusion which sometimes leads to a tendency to unhealthy means of escape such as alcohol or drugs.  Deception must be avoided."},
  {"c02b10",  "^^(B) is likely to try and dominate ^^(A)- especially in the home environment."},
  {"c02c01",  "You have an excellent compatibility indicator because ^^(Bp) sun is close to ^^(Ap) moon.  ^^(B) is likely to have a strong influence over ^^(A)."},
  {"c02c02",  "You have a great deal of emotional understanding of each other.  You will go through the same moods at the same time. You will have very strong family ties.  In business, you could do well in real estate, home products or food."},
  {"c02c03",  "You have excellent communication about everyday matters.  ^^(A) could see ^^(B) as a little too mental in approach  and ^^(B) could see ^^(A) as a little too emotional."},
  {"c02c04",  "Your domestic or emotional relationship is a strong bond between you.  This is a good indicator of luck in love.  You could have many pleasant times together, especially in the arts."},
  {"c02c05",  "^^(A) sees ^^(B) as too crude and assertive while ^^(B) sees  ^^(A) as too sensitive and moody."},
  {"c02c06",  "Trust and friendliness characterize your relationship.  This is excellent for business relationships also."},
  {"c02c07",  "^^(A) sees ^^(B) as being too cold and calculating, while ^^(B) sees ^^(A) as too sensitive and moody.  This could be alright for a business relationship."},
  {"c02c08",  "The relationship may not be so stable since ^^(A) will see ^^(B) as too erratic and willful."},
  {"c02c09",  "You probably have strong psychic communication and are very attuned to the feelings of each other."},
  {"c02c10",  "The great power of ^^(B) can threaten ^^(Ap) sensitivity."},
  {"c02g01",  "There is a very good aspect between ^^(Bp) sun and ^^(Ap) moon which is an excellent indicator of compatibility."},
  {"c02g02",  "You have excellent emotional rapport, especially in family relationships."},
  {"c02g03",  "You have excellent communication about everyday matters. "},
  {"c02g04",  "Your domestic or emotional relationship forms a strong bond between you.  This is a good indicator of luck in love.  You could have many pleasant times together, especially in the arts."},
  {"c02g05",  "^^(A) will calm and sensitize ^^(Bp) assertiveness while ^^(B)  will encourage ^^(A) to be more self-confident."},
  {"c02g06",  "Trust and friendliness characterize your relationship.  This is excellent for business relationships also."},
  {"c02g07",  "A business relationship is good for you two.  ^^(A) receives the practicality and discipline from ^^(B) and ^^(B) receives a more \"feeling\" approach.  Good businesses are real estate, home products or food."},
  {"c02g08",  "^^(B) can bring more change and excitement into ^^(Ap) life, while ^^(A) can bring moral support to ^^(Bp) humanitarian projects."},
  {"c02g09",  "You probably have strong psychic communication and are very attuned to the feelings of the other."},
  {"c02g10",  "The great power of ^^(B) can threaten ^^(Ap) sensitivity, although ^^(B) can help ^^(A) in any self-improvement."},
  {"c03b01",  "There are some communication difficulties in your relationship.  ^^(A) feels ^^(B) is too authoritarian, while ^^(B) feels ^^(A) is too changeable."},
  {"c03b02",  "There are problems in communicating about everyday matters.  Also a lot of time can be wasted in discussing unimportant things."},
  {"c03b03",  "There are many issues in communication which cause trouble because of your conflicting points of view."},
  {"c03b04",  "There are problems communicating about each others emotions."},
  {"c03b05",  "You will have plenty of arguments and sharp-tongued attacks.   ^^(A) will look on ^^(B) as too harsh and argumentative, while ^^(B) will look on ^^(A) as all talk and no action."},
  {"c03b06",  "The partnership should avoid an over-optimistic outlook and biting off more than you can chew."},
  {"c03b07",  "There are difficulties because ^^(A) sees ^^(B) as too negative, slow and self-disciplined.  Communication is  hard to achieve."},
  {"c03b08",  "^^(A) regards ^^(B) as very erratic and undisciplined, so that ^^(A) would fear any joint project all the time because ^^(B) is seen as capable of actions which are too sudden and drastic.  From ^^(Ap) point of view the project would be constantly in danger.  There will be major differences of opinion."},
  {"c03b09",  "^^(A) sees ^^(B) as an impractical dreamer who cannot be relied upon.  Deception needs to be avoided."},
  {"c03b10",  "^^(B) will try to dominate ^^(Ap) thinking and even be dictatorial."},
  {"c03c01",  "^^(B) is likely to stimulate ^^(Ap) thinking and there will be a lot of communication in the relationship."},
  {"c03c02",  "You have excellent communication about everyday matters.  ^^(B) could see ^^(A) as a little too mental in approach  and ^^(A) could see ^^(B) as a little too emotional."},
  {"c03c03",  "You enjoy similar viewpoints and have very similar interests and love to talk about them."},
  {"c03c04",  "Your relationship is generally happy and cheerful. You communicate  well, especially about creative activities."},
  {"c03c05",  "There's a great deal of communication between you- both good and bad."},
  {"c03c06",  "You can share many interests of an expansive kind- religion, philosophy, travel, law or literature."},
  {"c03c07",  "You can do well in business because of ^^(Bp) insistence on a practical, careful approach.  In other relationships ^^(A) will regard ^^(B) as too heavy and negative."},
  {"c03c08",  "You have an amazingly diverse range of interests which you love to discuss with each other.  As a team you could come up with some very original and unusual ideas.  You could do well in science- especially electronics in any form.  You can be involved in things at the leading edge- like computers, science fiction, astrology or psychic phenomena."},
  {"c03c09",  "You could be able to read each other's minds.  ^^(B) should be aware that vagueness can drive ^^(A) bananas."},
  {"c03c10",  "There could be a tendency for ^^(B) to dominate the decisions of ^^(A).  In any case there is a strong mental bond."},
  {"c03g01",  "You have excellent communication between you, especially on ^^(Ap) part."},
  {"c03g02",  "You have excellent communication about everyday matters. "},
  {"c03g03",  "You enjoy similar viewpoints and have very similar interests and love to talk about them."},
  {"c03g04",  "Your relationship is generally happy and cheerful. You communicate  well, especially about creative activities."},
  {"c03g05",  "There's a great deal of communication between you and you can co-operate well on any communication project."},
  {"c03g06",  "You can share many interests of an expansive kind- religion, philosophy, law, travel or literature."},
  {"c03g07",  "You have an excellent indicator of success in business and professional relationships.  This works best if ^^(B) is the older or more experienced person."},
  {"c03g08",  "You have an amazingly diverse range of interests which you love to discuss with each other.  As a team you could come up with some very original and unusual ideas.  You could do well in science- especially electronics in any form.  You can be involved in things at the leading edge- like computers, science fiction, astrology or psychic phenomena."},
  {"c03g09",  "You could be able to read each other's minds.  This is good for creative partnerships. In any case there is a strong mental bond between you."},
  {"c03g10",  "You can do very well in combined research or investigation."},
  {"c04b01",  "There could be some money difficulties in the relationship.  Also there are problems in emotional give and take."},
  {"c04b02",  "There are various emotional misunderstandings between you. You can put too much emphasis on material things."},
  {"c04b03",  "There are problems communicating about each others emotions."},
  {"c04b04",  "The emotional needs of each one of you are expecting to be fulfilled in two entirely different ways."},
  {"c04b05",  "There can be extremely strong passions between you so lasting harmony, while possible, is unlikely.  This is a  very difficult indicator."},
  {"c04b06",  "Social or financial advancement can play too large a role in the relationship.   Business partnerships are particularly unfortunate."},
  {"c04b07",  "Your relationship may be involuntary and a matter of duty. A romantic relationship could well be with someone of considerable difference in age or in wealth or in social status.  ^^(A) could regard ^^(B) as being too cold or self-disciplined."},
  {"c04b08",  "Your relationship can be too unconventional.  You could have an exciting but very unstable partnership.  Business schemes can be unreliable."},
  {"c04b09",  "If the relationship is romantic it is very likely to be one-sided, insincere or deceptive.  One of you could regard the other only through rose-coloured glasses, ignoring the real-world faults in the other person."},
  {"c04b10",  "A romantic relationship can be very intense and passionate.   Unfortunately, financial gain could play a role.  Jealousy and possessiveness are present.  Business relationships will have big trouble involving the disposition of the money."},
  {"c04c01",  "Your relationship can be are cheerful and affectionate  and you could have joint interests in music or art.  You  will have fun together and you're both good with children. This is an excellent indicator of romantic attraction."},
  {"c04c02",  "A strong bond exists in your domestic or emotional relationship.  This is a good indicator of luck in love.  You could have many pleasant times together, especially in the arts."},
  {"c04c03",  "Your relationship is generally happy and cheerful. You communicate  well, especially about creative activities."},
  {"c04c04",  "You are very emotionally sympathetic toward each other and can share similar taste in the arts and entertainment."},
  {"c04c05",  "In a romantic relationship there is a strong attraction between you.  In business it is good for luxury products or public relations."},
  {"c04c06",  "You will be generous and kind to each other.  This is a strong and very favourable indication."},
  {"c04c07",  "^^(A) perceives that ^^(B) is emotionally restricted for some reason."},
  {"c04c08",  "In love you likely had a sudden attraction and maybe some exciting adventure.  Beware of a short-lived infatuation.   You could have sudden good luck in money."},
  {"c04c09",  "You have a strong emotional understanding.  A partnership in creative projects can do well."},
  {"c04c10",  "In a romantic relationship you have an intense attraction.  This is also a good indicator for business partnerships."},
  {"c04g01",  "You have a good indication for romantic compatibility.  You enjoy each other's company and share many interests, including children or show business.  In a business relationship dealings are favoured in entertainment, sports or luxury items."},
  {"c04g02",  "Your domestic or emotional relationship shows a strong bond between you.  This is a good indicator of luck in love.  You could have many pleasant times together, especially in the arts."},
  {"c04g03",  "Your relationship is generally happy and cheerful. You communicate  well, especially about creative activities."},
  {"c04g04",  "You are very emotionally sympathetic toward each other and can share similar taste in the arts and entertainment."},
  {"c04g05",  "In a romantic relationship there is a strong attraction between you.  In business it is good for luxury products or public relations.  There is much overall compatibility."},
  {"c04g06",  "You will be generous and kind to each other.  This is a strong indication."},
  {"c04g07",  "There is a strong sense of loyalty in the relationship.  This is ideal for a parent-child relationship, especially if ^^(B) were the parent."},
  {"c04g08",  "In love you likely had a sudden attraction and maybe some exciting adventure.  Joint projects in electronic art can be good.  You could have sudden good luck in money."},
  {"c04g09",  "You have a strong emotional understanding.  A partnership in creative projects can do well."},
  {"c04g10",  "In a romantic relationship you have an intense attraction.  This is also a good indicator for business partnerships."},
  {"c05b01",  "Impulsive behavior and temper flare-ups can cause a lot of trouble, especially from ^^(A)."},
  {"c05b02",  "There is an unfortunate situation where ^^(Ap) overly forceful actions will cause trouble and ^^(Bp) emotional weakness is painfully evident in comparison with ^^(A)."},
  {"c05b03",  "You will have plenty of arguments and sharp-tongued attacks.   ^^(B) will look on ^^(A) as too harsh and argumentative, while ^^(A) will look on ^^(B) as all talk and no action."},
  {"c05b04",  "There can be extremely strong passions between you so lasting harmony, while possible, is unlikely.  This is a  very difficult indicator."},
  {"c05b05",  "Your attitudes to action and business are fundamentally different.  Temperamental outbursts and trying to boss each other around leads to trouble."},
  {"c05b06",  "Conflicts can arise in religion, philosophy or education. "},
  {"c05b07",  "Business relationships are quite poor.  While ^^(A) wants to charge ahead, ^^(B) wants to be cautious."},
  {"c05b08",  "Rash unpredictable outbursts are likely.  ^^(A) is too assertive and ^^(B) is too unsteady.  Co-operation is very difficult. Patience and humility are needed, for you both want your own way at all costs.  Dangerous thrill-seeking can be a problem."},
  {"c05b09",  "^^(A) sees ^^(B) as being vague or even deceptive, while ^^(B) sees ^^(A) as rash and insensitive.  The result is that ^^(A) has angry outbursts and ^^(B) avoids the issue and acts evasively with ulterior motives."},
  {"c05b10",  "You have a powerful, intense relationship.  Both of you are very forceful and must work hard to avoid trouble.  Boxing, karate or judo are good sports for you because they let you work off the excess energy with no harm."},
  {"c05c01",  "Your relationship has high energy but ^^(Ap) self-assertion  can cause some conflicts."},
  {"c05c02",  "^^(B) sees ^^(A) as too crude and assertive while ^^(A) sees  ^^(B) as too sensitive and moody."},
  {"c05c03",  "There's a great deal of communication between you- both good and bad."},
  {"c05c04",  "In a romantic relationship there is a strong attraction between you.  In business it is good for luxury products or public relations."},
  {"c05c05",  "Trouble will arise from the impulsive and assertive drives of both of you.  There could be competition between you.  However, this is good for sports relationships."},
  {"c05c06",  "Your relationship has an abundance of enthusiasm so when you start out on a project there's no stopping you.  You could enjoy the freedom activities together- skiing, sailing, cycling, horses or hiking."},
  {"c05c07",  "Sometimes ^^(A) feels that ^^(B) restricts his activities, but a little self-control is very good.  ^^(A) can also energize ^^(Bp) somewhat conservative outlook."},
  {"c05c08",  "The relationship is threatened by impulsive and erratic behaviour on both your parts.  There will be sudden uncontrolled outbursts of temper."},
  {"c05c09",  "Your relationship can be good for the creative use of motion  or energy, e.g. dancing, skating or hatha yoga."},
  {"c05c10",  "You can work well together in police work, private investigation or science."},
  {"c05g01",  "You work well together in things involving action or initiative.  Working together in trades, sports or engineering is favoured."},
  {"c05g02",  "^^(B) will calm and sensitize ^^(Ap) assertiveness while ^^(A)  will encourage ^^(B) to be more self-confident."},
  {"c05g03",  "There's a great deal of communication between you and you can co-operate well on any communication project."},
  {"c05g04",  "In a romantic relationship there is a strong attraction between you.  In business it is good for luxury products or public relations.  There is much overall compatibility."},
  {"c05g05",  "Your relationship is good for action- be it sports, business enterprise or something else."},
  {"c05g06",  "Your relationship has an abundance of enthusiasm so when you start out on a project there's no stopping you.  You could enjoy the freedom activities together- skiing, sailing, cycling, horses or hiking."},
  {"c05g07",  "You have excellent relationship for business, the military, science, engineering or politics."},
  {"c05g08",  "Your relationship can be excellent for science, electronics, astrology, invention or science fiction."},
  {"c05g09",  "Your relationship can be good for the creative use of motion  or energy, e.g. dancing, skating or hatha yoga."},
  {"c05g10",  "You can work well together in police work, private investigation or science."},
  {"c06b01",  "^^(A) could lead the two of you into over-optimistic and  unrealistic projects.  You could have disputes over religion or philosophy."},
  {"c06b02",  "There can be family difficulties over religion.  In business, there needs to be a more practical approach."},
  {"c06b03",  "The partnership should avoid an over-optimistic outlook and biting off more than you can chew."},
  {"c06b04",  "Social or financial advancement can play too large a role in the relationship.   Business partnerships are particularly unfortunate."},
  {"c06b05",  "Conflicts can arise in religion, philosophy or education.  Also ^^(B) looks at ^^(A) as being lazy, while ^^(A) looks at ^^(B) as being too self-centred and assertive."},
  {"c06c01",  "You are mutually kind and generous, especially ^^(A), and  can team up well in religion, law, travel or philosophy."},
  {"c06c02",  "Trust and friendliness characterize your relationship.  This is excellent for business relationships also."},
  {"c06c03",  "You can share many interests of an expansive kind- religion, philosophy, law or literature."},
  {"c06c04",  "You will be generous and kind to each other.  This is a strong indication."},
  {"c06c05",  "Your relationship has an abundance of enthusiasm so when you start out on a project there's no stopping you.  You could enjoy the freedom activities together- skiing, sailing, cycling, horses or hiking."},
  {"c06g01",  "You are mutually kind and generous and  can team up well in religion, law, travel or philosophy."},
  {"c06g02",  "Trust and friendliness characterize your relationship.  This is excellent for business relationships also."},
  {"c06g03",  "You can share many interests of an expansive kind- religion, philosophy, law or literature."},
  {"c06g04",  "You will be generous and kind to each other.  This is a strong indication."},
  {"c06g05",  "Your relationship has an abundance of enthusiasm so when you start out on a project there's no stopping you.  You could enjoy the freedom activities together- skiing, sailing, cycling, horses or hiking."},
  {"c07b01",  "The relationship will be subject to frequent frustrations, but you can succeed through very hard work.  There can be some difficulty in dealing with laws and rules of all kinds."},
  {"c07b02",  "^^(Ap) moods can often be negative and great effort is needed to snap out of it.  The relationship often has numerous heavy burdens around it, especially around the home."},
  {"c07b03",  "There are difficulties because ^^(B) sees ^^(A) as too negative, slow and self-disciplined.  Communication is  difficult."},
  {"c07b04",  "Your relationship may be involuntary and a matter of duty. A romantic relationship could well be with someone of considerable difference in age or in wealth or in social status.  ^^(B) could regard ^^(A) as being too cold or self-disciplined."},
  {"c07b05",  "Business relationships are quite poor.  While ^^(B) wants to charge ahead, ^^(A) wants to be cautious."},
  {"c07c01",  "Your relationship is on the serious side which is good for business.  ^^(B) will see ^^(A) as too cool and unemotional but ^^(A) can help ^^(B) to be more disciplined and patience."},
  {"c07c02",  "^^(B) sees ^^(A) as being too cold and calculating, while ^^(A) sees ^^(B) as too sensitive and moody.  This could be alright for a business relationship."},
  {"c07c03",  "You can do well in business because of ^^(Ap) insistence on a practical, careful approach.  In other relationships ^^(B) will regard ^^(A) as too heavy and negative."},
  {"c07c04",  "^^(B) perceives that ^^(A) is emotionally restricted for some reason."},
  {"c07c05",  "Sometimes ^^(B) feels that ^^(A) restricts his activities, but a little self-control is very good.  ^^(B) can also energize ^^(Ap) somewhat conservative outlook."},
  {"c07g01",  "Your relationship is on the serious side- which is good for business.  ^^(B) will see ^^(A) as too cool and unemotional but ^^(A) can help ^^(B) to be more disciplined and patient."},
  {"c07g02",  "A business relationship is good for you two.  ^^(B) receives the practicality and discipline from ^^(A) and ^^(A) receives a more feeling approach.  Good businesses are real estate, home products or food."},
  {"c07g03",  "You have an excellent indicator of success in business and professional relationships.  This works best if ^^(A) is the older or more experienced person."},
  {"c07g04",  "There is a strong sense of loyalty in the relationship.  This is ideal for a parent-child relationship, especially if ^^(A) were the parent."},
  {"c07g05",  "You have excellent relationship for business, the military, science, engineering or politics."},
  {"c08b01",  "^^(B) sees ^^(A) as having erratic behaviour or perverse  wrong-headedness.  Business relationships are extremely difficult."},
  {"c08b02",  "^^(A) can have sudden big changes in mood and be impractical. ^^(A) will consider ^^(B) to be far too conservative."},
  {"c08b03",  "^^(B) regards ^^(A) as very erratic and undisciplined, so that ^^(B) would fear any joint project all the time because ^^(A) is seen as capable of actions which are too sudden and drastic.  From ^^(Bp) point of view the project would be constantly in danger.  There will be major differences in opinion."},
  {"c08b04",  "Your relationship can be too unconventional.  You could have an exciting but very unstable partnership.  Business schemes can be unreliable."},
  {"c08b05",  "Rash unpredictable outbursts are likely.  ^^(B) is too assertive and ^^(A) is too unsteady.  Co-operation is very difficult. Patience and humility are needed, for you both want your own way at all costs.  Dangerous thrill-seeking can be a problem."},
  {"c08c01",  "You two could have a sudden magnetic attraction.  ^^(B) could regard ^^(A) as being too unpredictable and too independent."},
  {"c08c02",  "The relationship may not be so stable since ^^(B) will see ^^(A) as too erratic and willful."},
  {"c08c03",  "You have an amazingly diverse range of interests which you love to discuss with each other.  As a team you could come up with some very original and unusual ideas.  You could do well in science- especially electronics in any form.  You can be involved in things at the leading edge- like computers, science fiction, astrology or psychic phenomena."},
  {"c08c04",  "In love you likely had a sudden attraction and maybe some exciting adventure.  Beware of a short-lived infatuation.   You could have sudden good luck in money."},
  {"c08c05",  "The relationship is threatened by impulsive and erratic behaviour on both your parts.  There will be sudden uncontrolled outbursts of temper."},
  {"c08g01",  "You two could have a sudden magnetic attraction.  You will share unusual interests."},
  {"c08g02",  "^^(A) can bring more change and excitement into ^^(Bp) life, while ^^(B) can bring moral support to ^^(Ap) humanitarian projects."},
  {"c08g03",  "You have an amazingly diverse range of interests which you love to discuss with each other.  As a team you could come up with some very original and unusual ideas.  You could do well in science- especially electronics in any form.  You can be involved in things at the leading edge- like computers, science fiction, astrology or psychic phenomena."},
  {"c08g04",  "In love you likely had a sudden attraction and maybe some exciting adventure.  Joint projects in electronic art can be good.  You could have sudden good luck in money."},
  {"c08g05",  "Your relationship can be excellent for science, electronics, astrology, invention or science fiction."},
  {"c09b01",  "^^(B) sees ^^(A) as having an impractical fogginess which can lead to deception.  You will have many misunderstandings in the relationship."},
  {"c09b02",  "The relationship is subject to emotional confusion which sometimes leads to a tendency to unhealthy means of escape such as alcohol or drugs.  Deception must be avoided."},
  {"c09b03",  "^^(B) sees ^^(A) as an impractical dreamer who cannot be relied upon.  Deception needs to be avoided."},
  {"c09b04",  "If the relationship is romantic it is very likely to be one-sided, insincere or deceptive.  One of you could regard the other only through rose-coloured glasses, ignoring the real-world faults."},
  {"c09b05",  "^^(B) sees ^^(A) as being vague or even deceptive, while ^^(A) sees ^^(B) as rash and insensitive.  The result is that ^^(B) has angry outbursts and ^^(A) avoids the issue and acts evasively with ulterior motives."},
  {"c09c01",  "You have a strong intuitive link. ^^(B) will regard ^^(A) as being too vague or evasive."},
  {"c09c02",  "You probably have strong psychic communication and are very attuned to the feelings of the other."},
  {"c09c03",  "You could be able to read each other's minds.  ^^(A) should be aware that vagueness can drive ^^(B) bananas."},
  {"c09c04",  "You have a strong emotional understanding.  A partnership in creative projects can do well."},
  {"c09c05",  "Your relationship can be good for the creative use of motion  or energy, e.g. dancing, skating or hatha yoga."},
  {"c09g01",  "You could have a psychic link between you.  ^^(A) can bring creative imagination to ^^(B)."},
  {"c09g02",  "You probably have strong psychic communication and are very attuned to the feelings of the other."},
  {"c09g03",  "You could be able to read each other's minds.  This is good for creative partnerships."},
  {"c09g04",  "You have a strong emotional understanding.  A partnership in creative projects can do well."},
  {"c09g05",  "Your relationship can be good for the creative use of motion  or energy, e.g. dancing, skating or hatha yoga."},
  {"c10b01",  "You have the classic indicator of a power struggle relationship.  There are plenty of money problems."},
  {"c10b02",  "^^(A) is likely to try and dominate ^^(B)- especially in the home environment."},
  {"c10b03",  "^^(A) will try to dominate ^^(Bp) thinking and even be dictatorial."},
  {"c10b04",  "A romantic relationship can be very intense and passionate.   Unfortunately, financial gain could play a role.  Jealousy and possessiveness are present.  Business relationships will have big trouble involving the disposition of the money."},
  {"c10b05",  "You have a powerful, intense relationship.  Both of you are very forceful and must work hard to avoid trouble.  Boxing, karate or judo are good sports for you because they let you work off the excess energy with no harm."},
  {"c10c01",  "There could be a clash of wills.  ^^(A) could try to transform ^^(B).  It will take some doing to respect each other's freedom."},
  {"c10c02",  "The great power of ^^(A) can threaten ^^(Bp) sensitivity."},
  {"c10c03",  "There could be a tendency for ^^(A) to dominate the decisions of ^^(B).  In any case there is a strong mental bond."},
  {"c10c04",  "In a romantic relationship you have an intense attraction.  This is also a good indicator for business partnerships."},
  {"c10c05",  "You can work well together in police work, private investigation or science."},
  {"c10g01",  "^^(A) can bring money to the relationship or the ability to turn a business around."},
  {"c10g02",  "The great power of ^^(A) can threaten ^^(Bp) sensitivity, although ^^(A) can help ^^(B) in any self-improvement."},
  {"c10g03",  "You can do very well in combined research or investigation."},
  {"c10g04",  "In a romantic relationship you have an intense attraction.  This is also a good indicator for business partnerships."},
  {"c10g05",  "You can work well together in police work, private investigation or science."}
};

#define G_NKEYS_ASP (sizeof g_asptab / sizeof(struct g_aspect))


/* end of grphtm.h */
