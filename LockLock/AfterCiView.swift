//
//  AfterCiView.swift
//  LockLock
//
//  Created by Devin Maleke on 21/03/23.
//

import SwiftUI

struct AfterCiView: View {
    @EnvironmentObject var dbQuery: DBQuery
    

    var body: some View {
        NavigationView{
            VStack (alignment: .leading){
                
                HStack(){
                    NavigationLink(destination: SelectLockerView().environmentObject(dbQuery).navigationBarHidden(true)){
                        Label("Use-Locker", systemImage: "iconLocker")
                            .frame(width: 155, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                            .padding()
                    }
                    Label("Clock-out", systemImage: "arrow.up.circle")
                        .frame(width: 155, height: 40)
                        .foregroundColor(.white)
                        .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                        .cornerRadius(10)
                        
                    
                }
                HStack{
                    Text("January").padding([.top,.trailing],20)
                        .padding([.bottom],10)
                    Text("February").padding([.top,.trailing],20)
                        .padding([.bottom],10)
                    Text("March")
                        .padding([.top,.trailing],20)
                        .padding([.bottom],10)
                        .underline()
                    
                }
                
                List{VStack(alignment: .leading){
                Text("Today, 2023-03-17").font(Font.headline.weight(.bold))
                .foregroundColor(.black)
                Divider()
                HStack{
                    Label("Clock-in", systemImage: "clock")
                    Spacer()
                    Text("13.22").font(Font.headline.weight(.bold))
                }
                
                }}
                
                
                Spacer()
            }
            .padding()
            .padding(.top, 80)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ZStack{
                        Image("BackgroundTitle")
                            .resizable()
                            .frame(width: 400, height:200)
                            .scaledToFill()
                        VStack{
                            
                        
                            HStack{
                                
                                Text("Hi, Diana 👋")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Spacer()
                                
                            }.padding(.leading,20)
                        }.padding(.top,140)
                    }
                                }
                            }
                            .navigationBarTitleDisplayMode(.inline)
        }
        }
}

struct AfterCiView_Previews: PreviewProvider {
    static var previews: some View {
        AfterCiView()
    }
}
