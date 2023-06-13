//
//  SelectLockerView.swift
//  LockLock
//
//  Created by Devin Maleke on 21/03/23.
//

import SwiftUI

//struct Locker: Identifiable {
//    let id: Int
//    var isOccupied: Bool
//}

struct SmallPopupView: View {
    @State private var isShowingPopup2 = false
    @Binding var isPresented: Bool
    @State var counter = 0
    @Binding var currentIndex: Int
    @EnvironmentObject var dbQuery: DBQuery
    @State var randomLocker: [Locker] = []
    @State var randomList: String = ""
    
    var body: some View {
        
        ZStack{
            VStack {
                Text("How many locker do you need?")
                    .font(.headline)
                    .padding()
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 2)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 50)
                    .overlay(
                        HStack{
                            Button(action: {
                                self.counter-=1
                            }, label: {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 1)
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .overlay(
                                        Text("-")
                                            .foregroundColor(.black)
                                        
                                    )
                            }).disabled(self.counter<=0)
                            Spacer()
                            Text("\(counter)")
                                .bold()
                                .font(Font.system(size:30))
                            Spacer()
                            Button(action: {
                                self.counter+=1
                            }, label: {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 1)
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .overlay(
                                        Text("+")
                                        .foregroundColor(.black)
                                    )
                            }).disabled(self.counter>=3 || self.counter>=dbQuery.availLockers[currentIndex])
        
                            
                        }).padding()
                
                Rectangle()
                    .foregroundColor(Color(red: -0.002, green: 0.502, blue: 0.662))
                    .frame(width: 150, height: 35)
                    .cornerRadius(10)
                    .overlay(
                        
                        
                        Button("Randomize") {
                            for i in 0..<self.counter{
                                randomLocker.append(dbQuery.lockers[currentIndex].filter{
                                    $0.isOccupied == false
                                }.randomElement()!)
                                dbQuery.lockers[currentIndex][randomLocker[i].id - 1].isOccupied = true
                                dbQuery.lockers[currentIndex][randomLocker[i].id - 1].userId = dbQuery.curUser
                                dbQuery.toggleLockers(section: "\(LockerSection(rawValue: currentIndex)!)", id: randomLocker[i].id, action: true)
                            }
                            randomLocker.sort{
                                $0.id < $1.id
                            }
                            for i in randomLocker{
                                if(randomList.isEmpty){
                                    randomList += "\(LockerSection(rawValue: currentIndex)!)\(i.id)"
                                }
                                else{
                                    randomList += ", \(LockerSection(rawValue: currentIndex)!)\(i.id)"
                                }
                            }
                            isShowingPopup2 = true
                        }).foregroundColor(.white)
                    .font(.headline).disabled(self.counter == 0)
            }
            .frame(width: 300, height: 200)
            .background(Color.white)
            .cornerRadius(20)
            
            if isShowingPopup2 {
                
                VStack {
                    SmallPopupView2(isPresented2: $isShowingPopup2, currentIndex: $currentIndex, randomList: $randomList)
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .frame(width: 300,height: 300)
                
            }
        }
    }
}

struct SmallPopupView2: View {
    @Binding var isPresented2: Bool
    @State private var isAfterView2 = false
    @Binding var currentIndex: Int
    @Binding var randomList: String
    @EnvironmentObject var dbQuery: DBQuery
    var body: some View {
        VStack {
            Text("Congrats! You have successfully selected your locker(s)")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding()
                .padding(.bottom,25)
           
            Spacer()
            Image("Popup")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 5)
                .padding()
            
            Spacer()
            
            Text(randomList + "✨")
                .font(.title)
                .bold()
                .padding(.top,36)
                .padding(.bottom,1)
                .onAppear(perform: dbQuery.countAvailLockers)
            
            
            Button("Noted"){
                isAfterView2 = true
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 300)
            .tint(Color(red: -0.002, green: 0.502, blue: 0.662))
            .fullScreenCover(isPresented: $isAfterView2){
                AfterChooseLockerView(isOk: $isAfterView2)
                
            }

        }   .frame(width: 300, height: 300)
            .background(Color.white)
            .cornerRadius(20)
    }
}

struct SmallPopupView3: View {
    @Binding var isPresented3: Bool
    @State private var isAfterView = false
    @Binding var list: String
    @EnvironmentObject var dbQuery: DBQuery
    var body: some View {
        if list.isEmpty{
            //warning belom select locker
        }
        else{
            VStack {
                Text("Hi! Your locker(s) are at")
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom,25)
                    .onAppear(perform: {
                        dbQuery.countAvailLockers()
                    })
                
                Spacer()
                Image("Popup")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 5)
                    .padding()
                
                Spacer()
                Text(list + "✨")
                    .font(.title)
                    .bold()
                    .padding(.top,36)
                    .padding(.bottom,1)
                
                Button("Noted"){
                    isAfterView = true
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: -0.002, green: 0.502, blue: 0.662))
                .fullScreenCover(isPresented: $isAfterView){
                    AfterChooseLockerView(isOk: $isAfterView)
                    
                }
                
                
            }
            .frame(width: 300, height: 300)
            .background(Color.white)
            .cornerRadius(20)
        }
        
        }
        
    
}
struct SelectLockerView: View {
    @Environment(\.presentationMode) var presentationMode
    private var images = 4
    @State private var isShowingPopup = false
    @State private var isShowingPopup3 = false
    @State var currentIndex = 0
    @EnvironmentObject var dbQuery: DBQuery
    @State var list = ""
    
    var rows = 3
    @State var columns = 9
    
//    @State var lockers = (1...100).map { Locker(id: $0, isOccupied: false) }
    
  
    
    func previous(){
        withAnimation{
            currentIndex = currentIndex>0 ? currentIndex - 1: images - 1
        }
        
    }
    
    func next(){
        withAnimation{
            currentIndex = currentIndex < images ? currentIndex + 1 : 0
            
//            columns += 1
        }
        
        
    }
    
    var controls: some View{
        HStack{
            Button{
                previous()
            }label:{
                Image(systemName: "chevron.left")
            }
            .accentColor(.primary)
            Spacer()
                .frame(width: 100)
            Button{
                next()
            }label:{
                Image(systemName: "chevron.right")
            }
            .accentColor(.primary)
        }
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                }
                Spacer()
                
            }
            .padding(.leading,30)
            .padding(.top,10)
            .padding(.bottom,10)
            
            
            
            ZStack{
                VStack{
                    Label("Choose your locker location", systemImage: "map")
                        .font(Font.headline.weight(.bold))
                    
                    GeometryReader{
                        proxy in
                        VStack{
                            TabView(selection: $currentIndex){
                                
                                
                                ZStack{
                                    Image("LokerLab1A")
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(8)
                                        .overlay(Color.black.opacity(0.2))
                                    
                                        .padding();
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Text("Lab A: \(dbQuery.availLockers[0]) Avail")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(10)
                                                .frame(width: 200, height: 20,alignment: .trailing)
                                                .padding(.top,20)
                                        }
                                        .padding()
                                        Spacer()
                                    }
                                    
                                }.tag(0)
                                ZStack{
                                    Image("LokerLab1B")
                                        .resizable()
                                        .scaledToFill()
                                        .overlay(Color.black.opacity(0.2))
                                        .cornerRadius(8)
                                        .padding();
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Text("Lab B: \(dbQuery.availLockers[1]) Avail")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(10)
                                                .frame(width: 200, height: 10,alignment: .trailing)
                                                .padding(.top,20)
                                            
                                        }
                                        .padding()
                                        Spacer()
                                    }
                                    
                                }.tag(1)
                                
                                ZStack{
                                    Image("PantryA")
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(8)
                                        .overlay(Color.black.opacity(0.2))
                                    
                                        .padding();
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Text("Pantry A: \(dbQuery.availLockers[2]) Avail")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(10)
                                                .frame(width: 200, height: 10,alignment: .trailing)
                                                .padding(.top,20)
                                            
                                        }
                                        .padding()
                                        Spacer()
                                    }
                                    
                                }.tag(2)
                                
                                ZStack{
                                    Image("PantryB")
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(8)
                                        .overlay(Color.black.opacity(0.2))
                                    
                                        .padding();
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Text("Pantry B: \(dbQuery.availLockers[3]) Avail")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(10)
                                                .frame(width: 200, height: 10,alignment: .trailing)
                                                .padding(.top,20)
                                            
                                        }
                                        .padding()
                                        Spacer()
                                    }
                                    
                                }.tag(3)
                                
                                
                            }.tabViewStyle(PageTabViewStyle())
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding()
                                .frame(width: proxy.size.width, height:200)
                            
                            controls
                                .padding(.bottom,10)
                            
                            
                            //                    TabView(selection: $currentIndex){
                            //
                            //                        ForEach(0..<rows) { row in
                            //                            HStack {
                            //                                ForEach(0..<columns) { column in
                            //                                    let lockerIndex = row * columns + column
                            //                                    LockersView(locker: $lockers[lockerIndex])}}}
                            //
                            //
                            //                    }
                            //
                            VStack{
                                Text("Pick your locker(s) number").fontWeight(.heavy).padding(.top,10)
                                Text("Maximum 3 lockers")
                                    .fontWeight(.light)
                                    .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.356))
                                TabView(selection: $currentIndex){
                                    ScrollView(.horizontal){
                                        VStack{
                                            ForEach(0..<rows) { row in
                                                HStack {
                                                    ForEach(0..<columns) { column in
                                                        let lockerIndex = row * columns + column
                                                        LockersView(locker: $dbQuery.lockers[0][lockerIndex], isShowingPopup3: $isShowingPopup3, currentIndex: $currentIndex, list: $list).environmentObject(dbQuery)}
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }.tag(0)
                                        .padding()
                                        .background(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9647058823529412))
                                    
                                    ScrollView(.horizontal){
                                        VStack{
                                            ForEach(0..<rows) { row in
                                                HStack {
                                                    ForEach(0..<columns) { column in
                                                        let lockerIndex = row * columns + column
                                                        LockersView(locker: $dbQuery.lockers[1][lockerIndex], isShowingPopup3: $isShowingPopup3, currentIndex: $currentIndex, list: $list).environmentObject(dbQuery)}
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                            
                                        }
                                    }.tag(1)
                                        .padding()
                                        .background(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9647058823529412))
                                    
                                    ScrollView(.horizontal){
                                        VStack{
                                            
                                            
                                            ForEach(0..<3) { row in
                                                HStack {
                                                    ForEach(0..<18) { column in
                                                        let lockerIndex = row * 18 +  column
                                                        LockersView(locker: $dbQuery.lockers[2][lockerIndex], isShowingPopup3: $isShowingPopup3, currentIndex: $currentIndex, list: $list).environmentObject(dbQuery)}
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }.tag(2)
                                        .padding()
                                        .background(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9647058823529412))
                                    
                                    ScrollView(.horizontal){
                                        VStack{
                                            ForEach(0..<rows) { row in
                                                HStack {
                                                    ForEach(0..<15) { column in
                                                        let lockerIndex = row * 15 + column
                                                        LockersView(locker: $dbQuery.lockers[3][lockerIndex], isShowingPopup3: $isShowingPopup3, currentIndex: $currentIndex, list: $list).environmentObject(dbQuery)}
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                            
                                        }
                                    }.tag(3)
                                        .padding()
                                        .background(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9647058823529412))
                                }.frame(width:350 , height: 220)
                                    
                                
                                
                                HStack{
                                    Spacer()
                                    Button("Done >"){
                                        isShowingPopup3 = true
                                    }
                                    .bold()
                                    .padding()
                                    .padding(.trailing, 20)
                                }
                            }.background(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9647058823529412))
                                .cornerRadius(8)
                                .padding()
                                
                            
                            
                            
                            HStack{
                                Text("Help me choose my locker")
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 30)
                                
                                Button("Randomize"){
                                    isShowingPopup = true
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: -0.002, green: 0.502, blue: 0.662), lineWidth: 3)
                                        .frame(width: 120, height: 40)
                                )
                                
                                
                                
                            }.padding()
                        }
                        
                    }
                }
                
                if isShowingPopup3 {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            // Close the popup when tapped outside
                            isShowingPopup3 = false
                        }
                    
                    VStack {
                        Spacer()
                        SmallPopupView3(isPresented3: $isShowingPopup3, list: $list).environmentObject(dbQuery)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .frame(width: 100,height: 100)
                    
                }
                Spacer()
                if isShowingPopup {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            // Close the popup when tapped outside
                            isShowingPopup = false
                        }
                    
                    VStack {
                        Spacer()
                        SmallPopupView(isPresented: $isShowingPopup, currentIndex: $currentIndex)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .frame(width: 100,height: 100)
                    
                }
            }
        }
    }
    }
    

enum LockerSection: Int{
    case LA = 0
    case LB = 1
    case PA = 2
    case PB = 3
}


struct LockersView: View {
    @EnvironmentObject var dbQuery: DBQuery
    @Binding var locker: Locker
    @State var isSelected = false
    @Binding var isShowingPopup3: Bool
    @Binding var currentIndex: Int
    @State var section = ""
    @Binding var list: String
    
//    init(locker: Locker, isShowingPopup3: Bool, currentIndex: Int){
//        switch currentIndex{
//        case 0:
//            section = "LA"
//        case 1:
//            section = "LB"
//        case 2:
//            section = "PA"
//        case 3:
//            section = "PB"
//        default:
//            section = "?"
//        }
//    }
    func getScoreColor() -> Color {
        if locker.isOccupied{
            return Color(red: 0.727, green: 0.717, blue: 0.726)
        } else if isSelected{
            return Color(red: 0.0, green: 0.5019607843137255, blue: 0.6627450980392157)
        } else {
            return .white
        }
    }
    
    func getScoreColor2() -> Color {
        if locker.isOccupied{
            return .black
        } else if isSelected{
            return .white
        } else {
            return .black
        }
    }
    var body: some View {

        Button(action: {
            isSelected.toggle()
        }) {
            RoundedRectangle(cornerRadius: 15)
                .background(RoundedRectangle(cornerRadius: 15))
//                .foregroundColor(isSelected ? .blue : .white)
                .foregroundColor(getScoreColor())
                .frame(width: 50, height: 50)
                .overlay(
                    Text("\(locker.id)")
                        .fontWeight(.semibold)
                        .foregroundColor(getScoreColor2())
                
                )
            
        }
        .onChange(of: currentIndex, perform: { newValue in
            isSelected = false;
        })
        .onChange(of: isShowingPopup3, perform: { newValue in
//            list = ""
            guard let section = LockerSection(rawValue: currentIndex) else { return }
            if(isSelected){
                if(list.count < 2){
                    list = "\(section)\(locker.id)"
                }
                else{
                    list.insert(contentsOf: "\(section)\(locker.id), ", at: list.startIndex)
                }
                submit(section)
            }
        })
        .disabled(locker.isOccupied)
    }
    
    func submit(_ section: LockerSection){
        print("\(section)  \(locker.id)")
        dbQuery.lockers[currentIndex][locker.id-1].isOccupied = true
        dbQuery.lockers[currentIndex][locker.id-1].userId = dbQuery.curUser
        dbQuery.toggleLockers(section: "\(section)", id: locker.id, action: true)
    }
}

struct SelectLockerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLockerView().environmentObject(DBQuery())
    }
}
